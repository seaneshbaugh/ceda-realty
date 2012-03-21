require "will_paginate"

class Admin::PicturesController < Admin::AdminController
	def index
		per_page = params[:per_page]

		per_page ||= 25

		if !params[:sort].nil? and !params[:order].nil?
			sort_order = params[:sort].to_s + " " + params[:order].to_s
		else
			sort_order = "created_at DESC"
		end

		if !params[:search].blank?
			search = "%" + params[:search] + "%"

			@pictures = Picture.paginate(:page => params[:page], :per_page => per_page, :order => sort_order, :conditions => ['name LIKE ?', search])
		else
			@pictures = Picture.paginate(:page => params[:page], :per_page => per_page, :order => sort_order)
		end

		@page_title = "Pictures"

		if mobile_browser?
			render :action => "index_mobile"
		end
	end

	def show
		@picture = Picture.find_by_id(params[:id])

		if @picture.nil?
			flash[:type] = "error"

			flash[:notice] = error_message_could_not_find("picture")

			redirect_to(admin_root_url) and return
		end

		@page_title = "View Picture - " + @picture.title

		if mobile_browser?
			render :action => "show_mobile"
		end
	end

	def new
		@picture = Picture.new

		@page_title = "New Picture"

		if mobile_browser?
			render :action => "new_mobile"
		end
	end

	def create
		if params[:attachment][:file].blank?
			flash[:type] = "error"

			flash[:notice] = "Error: No image uploaded."

			redirect_to(new_admin_picture_url) and return
		end

		@picture = Picture.new(params[:picture])

		if !@picture.nil?
			result, message = @picture.save_image(params[:attachment][:file])

			if result != true
				@picture.delete_image

				flash[:type] = "error"

				flash[:notice] = message

				redirect_to(new_admin_picture_url) and return
			end

			if !params[:page][:page_id].blank?
				@picture.attachable_id = params[:page][:page_id]

				@picture.attachable_type = "Page"
			end

			if !params[:listing][:listing_id].blank?
				@picture.attachable_id = params[:listing][:listing_id]

				@picture.attachable_type = "Listing"
			end

			if !params[:agent_resource][:agent_resource_id].blank?
				@picture.attachable_id = params[:agent_resource][:agent_resource_id]

				@picture.attachable_type = "AgentResource"
			end

			if @picture.save
				LoggerEvent.new(:person_id => @user.id, :event_type => LoggerEvent::EventTypeObjectCreated, :description => "Uploaded new picture #{@picture.id} - #{@picture.title}.", :visible => true).save

				flash[:type] = "success"

				flash[:notice] = notice_message_created("picture")

				redirect_to(admin_pictures_url) and return
			else
				@item.delete_image

				flash[:type] = "error"

				flash[:notice] = error_message_could_not_save("picture")

				redirect_to(new_admin_picture_url) and return
			end
		else
			flash[:type] = "error"

			flash[:notice] = error_message_could_not_create("picture")

			redirect_to(new_admin_picture_url) and return
		end
	end

	def edit
		@picture = Picture.find_by_id(params[:id])

		if @picture.nil?
			flash[:type] = "error"

			flash[:notice] = error_message_could_not_find("picture")

			redirect_to(admin_pictures_url) and return
		end

		@page_title = "Edit Picture - " + @picture.title

		if mobile_browser?
			render :action => "edit_mobile"
		end
	end

	def update
		@picture = Picture.find_by_id(params[:id])

		if !@picture.nil?
			if !params[:attachment].blank?
				result, message = Picture.validate_image_content_type(params[:attachment][:file])

				if result != true
					flash[:type] = "error"

					flash[:notice] = message

					redirect_to(edit_admin_picture_url(@picture)) and return
				end
			end

			if !@picture.update_attributes(params[:picture])
				flash[:error] = "error"

				flash[:notice] = error_message_could_not_update("picture")

				redirect_to(edit_admin_picture_url(@picture)) and return
			end

			if !params[:page][:page_id].blank?
				@picture.attachable_id = params[:page][:page_id]

				@picture.attachable_type = "Page"
			end

			if !params[:listing][:listing_id].blank?
				@picture.attachable_id = params[:listing][:listing_id]

				@picture.attachable_type = "Listing"
			end

			if !params[:agent_resource][:agent_resource_id].blank?
				@picture.attachable_id = params[:agent_resource][:agent_resource_id]

				@picture.attachable_type = "AgentResource"
			end

			if !params[:attachment].blank?
				result, message = @picture.save_image(params[:attachment][:file])

				if result != true
					@picture.delete_image

					flash[:type] = "error"

					flash[:notice] = message

					redirect_to(edit_admin_picture_url(@picture)) and return
				end
			end

			if @picture.save
				LoggerEvent.new(:person_id => @user.id, :event_type => LoggerEvent::EventTypeObjectModified, :description => "Modified picture #{@picture.id} - #{@picture.title}.", :visible => true).save

				flash[:type] = "success"

				flash[:notice] = notice_message_updated("picture")

				redirect_to(admin_picture_url(@picture)) and return
			else
				flash[:type] = "error"

				flash[:notice] = error_message_could_not_save("picture")

				redirect_to(edit_admin_picture_url(@picture)) and return
			end
		else
			flash[:type] = "error"

			flash[:notice] = error_message_could_not_find("picture")

			redirect_to(admin_pictures_url) and return
		end
	end

	def destroy
		@picture = Picture.find_by_id(params[:id])

		if !@picture.nil?
			#this has to go first otherwise @picture will be undefined (I think)
			LoggerEvent.new(:person_id => @user.id, :event_type => LoggerEvent::EventTypeObjectDeleted, :description => "Deleted picture #{@picture.id} - #{@picture.title}.", :visible => true).save

			begin
				Picture.destroy(@picture)
			rescue Exception => error
				flash[:type] = "error"

				flash[:notice] = error.message

				redirect_to(edit_admin_picture_url(@picture)) and return
			end

			flash[:type] = "success"

			flash[:notice] = notice_message_destroyed("picture")

			redirect_to(admin_pictures_url) and return
		else
			flash[:type] = "error"

			flash[:notice] = error_message_could_not_find("picture")

			redirect_to(admin_pictures_url) and return
		end
	end

	def edit_multiple
		@pictures = Picture.find(params[:picture_ids])

		if @pictures.nil?
			flash[:type] = "error"

			flash[:notice] = error_message_could_not_find("one or more of the selected pictures")

			redirect_to(admin_pictures_url) and return
		end

		@page_title = "Edit Multiple Pictures"
	end

	def update_multiple
		@pictures = Picture.find(params[:picture_ids])

		for picture in @pictures
			#we should use proper error control here, but since it's complicated
			#for now we'll use update_attributes! which will just throw an unhandled
			#exception if anything goes wrong.
			picture.update_attributes!(params[:picture].reject { |k, v| v.blank? })

			LoggerEvent.new(:person_id => @user.id, :event_type => LoggerEvent::EventTypeObjectModified, :description => "Modified picture #{picture.id} - #{picture.title}.", :visible => true).save
		end

		flash[:type] = "success"

		flash[:notice] = notice_message_updated("all pictures")

		redirect_to(admin_pictures_url) and return
	end

	def destroy_multiple
		@pictures = Picture.find(params[:picture_ids])

		for picture in @pictures
			#this has to go first otherwise picture will be undefined (I think)
			LoggerEvent.new(:person_id => @user.id, :event_type => LoggerEvent::EventTypeObjectDeleted, :description => "Deleted picture #{picture.id} - #{picture.title}.", :visible => true).save

			begin
				Picture.destroy(picture)
			rescue Exception => error
				flash[:type] = "error"

				flash[:notice] = error.message

				redirect_to(edit_admin_picture_url(@picture)) and return
			end
		end

		flash[:type] = "success"

		flash[:notice] = notice_message_destroyed("all pictures")

		redirect_to(admin_pictures_url) and return
	end
end
