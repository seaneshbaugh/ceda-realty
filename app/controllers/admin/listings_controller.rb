require "will_paginate"

class Admin::ListingsController < Admin::AdminController
	before_filter :is_admin?

	def index
		per_page = params[:per_page]

		per_page ||= 25

		params[:submit] = nil

		if !params[:sort].nil? and !params[:order].nil?
			sort_order = params[:sort].to_s + " " + params[:order].to_s
		else
			sort_order = "id ASC"
		end

		if !params[:search].blank?
			search = "%" + params[:search] + "%"

			@listings = Listing.paginate(:page => params[:page], :per_page => per_page, :order => sort_order, :conditions => ['street_address LIKE ?', search])
		else
			@listings = Listing.paginate(:page => params[:page], :per_page => per_page, :order => sort_order)
		end

		@page_title = "Listings"
	end

	def show
		@listing = Listing.find_by_id(params[:id])

		if @listing.nil?
			flash[:type] = "error"

			flash[:notice] = error_message_could_not_find("listing")

			redirect_to(admin_listings_url) and return
		end

		@page_title = "View Listing - " + @listing.street_address
	end

	def new
		@listing = Listing.new

		@page_title = "New Listing"
	end

	def create
		@listing = Listing.new(params[:listing])

		if !@listing.nil?
            if params[:page][:display_order].nil?
                @page.display_order = 0
            end

			if @page.save
				@listing.bump_display_order

				LoggerEvent.new(:person_id => @user.id, :event_type => LoggerEvent::EventTypeObjectCreated, :description => "Created new page #{@page.id} - #{@page.title}.", :visible => true).save

				flash[:type] = "success"

				flash[:notice] = notice_message_created("page")

				redirect_to(admin_page_url(@page)) and return
			else
				flash[:type] = "error"

				flash[:notice] = format_error_messages(@listing.errors)

				redirect_to(new_admin_page_url) and return
			end
		else
			flash[:type] = "error"

			flash[:notice] = error_message_could_not_create("page")

			redirect_to(new_admin_page_url) and return
		end
	end

	def import
		if !params[:mls_number].nil?
			@listing = Listing.new

			if @listing.import_attributes_from_mls(params[:mls_number])
				@listing.mls_number = params[:mls_number]

				if @listing.save
					flash[:type] = "information"

					flash[:notice] = "Successfully imported the listing with MLS number #{params[:mls_number]}.<br />It is strongly recommended that you double check the listing's properties."

					if params[:listing_import_pictures]
						@listing.import_pictures_from_mls

						#flash[:notice] << "<br />Attempted to import images.<br />Need to add the ability to tell how many succedded and how many failed"
					end

					redirect_to(edit_admin_listing_url(@listing)) and return
				else
					flash[:type] = "error"

					flash[:notice] = format_error_messages(@listing.errors)

					redirect_to(new_admin_listing_url) and return
				end
			else
				flash[:type] = "error"

				flash[:notice] = "Error: Could not import listing from MLS."

				redirect_to(new_admin_listing_url) and return
			end
		else
			flash[:type] = "error"

			flash[:notice] = "Error: No MLS number given."

			redirect_to(new_admin_listing_url) and return
		end
	end

	def edit
		@listing = Listing.find_by_id(params[:id])

		if @listing.nil?
			flash[:type] = "error"

			flash[:notice] = error_message_could_not_find("listing")

			redirect_to(admin_listings_url) and return
		end

		@page_title = "Edit Listing - " + @listing.street_address
	end

	def update
		@listing = Listing.find_by_id(params[:id])

		if !@listing.nil?
            old_display_order = @listing.display_order

			if @listing.update_attributes(params[:listing])
				LoggerEvent.new(:person_id => @user.id, :event_type => LoggerEvent::EventTypeObjectModified, :description => "Modified listing #{@listing.id} - #{@listing.street_address}.", :visible => true).save

				flash[:type] = "success"

				flash[:notice] = notice_message_updated("listing")
			else
				flash[:type] = "error"

				flash[:notice] = error_message_could_not_update("listing")
			end

            if @listing.display_order != old_display_order
                @listing.bump_display_order
            end

			redirect_to(edit_admin_listing_url(@listing)) and return
		else
			flash[:type] = "error"

			flash[:notice] = error_message_could_not_find("listing")

			redirect_to(admin_listings_url) and return
		end
	end

	def destroy
		@listing = Listing.find_by_id(params[:id])

		if !@listing.nil?
			#this has to go first otherwise page will be undefined (I think)
			LoggerEvent.new(:person_id => @user.id, :event_type => LoggerEvent::EventTypeObjectDeleted, :description => "Deleted listing #{@listing.id} - #{@listing.street_address}.", :visible => true).save

			Listing.destroy(@listing)

			flash[:type] = "success"

			flash[:notice] = notice_message_destroyed("listing")
		else
			flash[:type] = "error"

			flash[:notice] = error_message_could_not_find("listing")
		end

		redirect_to(admin_listings_url) and return
	end

	def edit_multiple
		#@pages = Page.find(params[:page_ids])
		@listing = HierarchySorter.new(Listing.find(params[:listing_ids])).sorted_array

		if @listing.nil?
			flash[:type] = "error"

			flash[:notice] = error_message_could_not_find("one or more of the selected listing")

			redirect_to(admin_listings_url) and return
		end

		@page_title = "Edit Multiple Listings"
	end

	def update_multiple
		@listings = Page.find(params[:listing_ids])

		for listing in @listings
			#we should use proper error control here, but since it's complicated
			#for now we'll use update_attributes! which will just throw an unhandled
			#exception if anything goes wrong.
			listing.update_attributes!(params[:page].reject { |k, v| v.blank? })

			LoggerEvent.new(:person_id => @user.id, :event_type => LoggerEvent::EventTypeObjectModified, :description => "Modified listing #{listing.id} - #{listing.title}.", :visible => true).save
		end

		flash[:type] = "success"

		flash[:notice] = notice_message_updated("all listings")

		redirect_to(admin_listings_url) and return
	end

	def destroy_multiple
		@listings = Listing.find(params[:listing_ids])

		for listing in @listings
			#this has to go first otherwise listing will be undefined (I think)
			LoggerEvent.new(:person_id => @user.id, :event_type => LoggerEvent::EventTypeObjectDeleted, :description => "Deleted listing #{listing.id} - #{listing.title}.", :visible => true).save

			Listing.destroy(listing)
		end

		flash[:type] = "success"

		flash[:notice] = notice_message_destroyed("all listings")

		redirect_to(admin_listings_url) and return
	end
end
