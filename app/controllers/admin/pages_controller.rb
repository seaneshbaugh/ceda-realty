require "will_paginate"
require "hierarchy"

class Admin::PagesController < Admin::AdminController
	def index
		#@pages = HierarchySorter.new(Page.find(:all)).sorted_array

		per_page = params[:per_page]

		per_page ||= 25

		params[:submit] = nil

		if !params[:sort].nil? and !params[:order].nil?
			sort_order = params[:sort].to_s + " " + params[:order].to_s
		else
			sort_order = "id DESC"
		end

		if !params[:search].blank?
			search = "%" + params[:search] + "%"

			@pages = Page.paginate(:page => params[:page], :per_page => per_page, :order => sort_order, :conditions => ['title LIKE ?', search])
		else
			@pages = Page.paginate(:page => params[:page], :per_page => per_page, :order => sort_order)
		end

		@page_title = "Pages"

		if mobile_browser?
			render :action => "index_mobile"
		end
	end

	def show
		@page = Page.find_by_slug(params[:id])

		if @page.nil?
			flash[:type] = "error"

			flash[:notice] = error_message_could_not_find("page")

			redirect_to(admin_pages_url) and return
		end

		@page_title = "View Page - " + @page.title

		if mobile_browser?
			render :action => "show_mobile"
		end
	end

	def new
		@page = Page.new

		@pictures = Picture.find(:all)

		@page_title = "New Page"

		if mobile_browser?
			render :action => "new_mobile"
		end
	end

	def create
		@page = Page.new(params[:page])

		if !@page.nil?
			if !@page.parent_id.nil? and @page.parent.nil?
				flash[:type] = "error"

				flash[:notice] = "Error: Invalid parent page!"

				redirect_to(new_admin_page_url) and return
			end

            if params[:page][:display_order].nil?
                @page.display_order = 0
            end

			if @page.save
				@page.bump_display_order

				if @page.is_index != 0
					@page.make_index_page
				end

				LoggerEvent.new(:person_id => @user.id, :event_type => LoggerEvent::EventTypeObjectCreated, :description => "Created new page #{@page.id} - #{@page.title}.", :visible => true).save

				flash[:type] = "success"

				flash[:notice] = notice_message_created("page")

				redirect_to(admin_page_url(@page)) and return
			else
				flash[:type] = "error"

				flash[:notice] = format_error_messages(@page.errors)

				redirect_to(new_admin_page_url) and return
			end
		else
			flash[:type] = "error"

			flash[:notice] = error_message_could_not_create("page")

			redirect_to(new_admin_page_url) and return
		end
	end

	def edit
		@page = Page.find_by_slug(params[:id])

		if @page.nil?
			flash[:type] = "error"

			flash[:notice] = error_message_could_not_find("page")

			redirect_to(admin_pages_url) and return
		end

		if !@page.parent_id.nil? and @page.parent.nil?
			flash[:type] = "error"

			flash[:notice] = "Error: Invalid parent page!"

			redirect_to(admin_pages_url) and return
		end

		@pictures = Picture.find(:all)

		@page_title = "Edit Page - " + @page.title

		if mobile_browser?
			render :action => "edit_mobile"
		end
	end

	def update
		@page = Page.find_by_slug(params[:id])

		if !@page.nil?
			if !@page.parent_id.nil? and @page.parent.nil?
				flash[:type] = "error"

				flash[:notice] = "Error: Invalid parent page!"

				redirect_to(admin_pages_url) and return
			end

            old_display_order = @page.display_order

			if @page.update_attributes(params[:page])
				if @page.is_index != 0
					@page.make_index_page
				end

				LoggerEvent.new(:person_id => @user.id, :event_type => LoggerEvent::EventTypeObjectModified, :description => "Modified page #{@page.id} - #{@page.title}.", :visible => true).save

				flash[:type] = "success"

				flash[:notice] = notice_message_updated("page")
			else
				flash[:type] = "error"

				flash[:notice] = error_message_could_not_update("page")
			end

            if @page.display_order != old_display_order
                @page.bump_display_order
            end

			redirect_to(edit_admin_page_url(@page)) and return
		else
			flash[:type] = "error"

			flash[:notice] = error_message_could_not_find("page")

			redirect_to(admin_pages_url) and return
		end
	end

	def destroy
		@page = Page.find_by_slug(params[:id])

		if !@page.nil?
			#this has to go first otherwise page will be undefined (I think)
			LoggerEvent.new(:person_id => @user.id, :event_type => LoggerEvent::EventTypeObjectDeleted, :description => "Deleted page #{@page.id} - #{@page.title}.", :visible => true).save

			Page.destroy(@page)

			flash[:type] = "success"

			flash[:notice] = notice_message_destroyed("page")
		else
			flash[:type] = "error"

			flash[:notice] = error_message_could_not_find("page")
		end

		redirect_to(admin_pages_url) and return
	end

	def edit_multiple
		#@pages = Page.find(params[:page_ids])
		@pages = HierarchySorter.new(Page.find(params[:page_ids])).sorted_array

		if @pages.nil?
			flash[:type] = "error"

			flash[:notice] = error_message_could_not_find("one or more of the selected pages")

			redirect_to(admin_pages_url) and return
		end

		@page_title = "Edit Multiple Pages"
	end

	def update_multiple
		@pages = Page.find(params[:page_ids])

		for page in @pages
			#we should use proper error control here, but since it's complicated
			#for now we'll use update_attributes! which will just throw an unhandled
			#exception if anything goes wrong.
			page.update_attributes!(params[:page].reject { |k, v| v.blank? })

			LoggerEvent.new(:person_id => @user.id, :event_type => LoggerEvent::EventTypeObjectModified, :description => "Modified page #{page.id} - #{page.title}.", :visible => true).save
		end

		flash[:type] = "success"

		flash[:notice] = notice_message_updated("all pages")

		redirect_to(admin_pages_url) and return
	end

	def destroy_multiple
		@pages = Page.find(params[:page_ids])

		for page in @pages
			#this has to go first otherwise page will be undefined (I think)
			LoggerEvent.new(:person_id => @user.id, :event_type => LoggerEvent::EventTypeObjectDeleted, :description => "Deleted page #{page.id} - #{page.title}.", :visible => true).save

			Page.destroy(page)
		end

		flash[:type] = "success"

		flash[:notice] = notice_message_destroyed("all pages")

		redirect_to(admin_pages_url) and return
	end
end
