require "will_paginate"

class Admin::AgentResourcesController < Admin::AdminController
	before_filter :is_admin?

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

			if !params[:category].blank?
				@agent_resources = AgentResource.paginate(:page => params[:page], :per_page => per_page, :order => sort_order, :conditions => ['name LIKE ? and category = ?', search, params[:category]])
			else
				@agent_resources = AgentResource.paginate(:page => params[:page], :per_page => per_page, :order => sort_order, :conditions => ['name LIKE ?', search])
			end
		else
			if !params[:category].blank?
				@agent_resources = AgentResource.paginate(:page => params[:page], :per_page => per_page, :order => sort_order, :conditions => ['category LIKE ?', params[:category]])
			else
				@agent_resources = AgentResource.paginate(:page => params[:page], :per_page => per_page, :order => sort_order)
			end
		end

		@page_title = "Agent Resources"

		if mobile_browser?
			render :action => "index_mobile"
		end
	end

	def show
		@agent_resource = AgentResource.find_by_id(params[:id])

		if @agent_resource.nil?
			flash[:type] = "error"

			flash[:notice] = error_message_could_not_find("agent resource")

			redirect_to(admin_root_url) and return
		end

		@page_title = "View Agent Resource - " + @agent_resource.name
	end

	def new
		@agent_resource = AgentResource.new

		@page_title = "New Agent Resource"
	end

	def create
		if params[:attachment].blank? and params[:agent_resource][:external_url].blank?
			flash[:type] = "error"

			flash[:notice] = "Error: No file uploaded or external URL specified."

			redirect_to(new_admin_agent_resource_url) and return
		end

		if !params[:attachment].blank? and !params[:agent_resource][:external_url].blank?
			flash[:type] = "error"

			flash[:notice] = "Error: You cannot upload a file and specify an external URL."

			redirect_to(new_admin_agent_resource_url) and return
		end

		@agent_resource = AgentResource.new(params[:agent_resource])

		@agent_resource.person = @user

		if !@agent_resource.nil?
			unless params[:attachment].blank?
				result, message = @agent_resource.save_file(params[:attachment][:file])

				if result != true
					@agent_resource.delete_file

					flash[:type] = "error"

					flash[:notice] = message

					redirect_to(new_admin_agent_resource_url) and return
				end
			end

			if @agent_resource.save
				LoggerEvent.new(:person_id => @user.id, :ip_address => request.remote_ip, :event_type => LoggerEvent::EventTypeObjectCreated, :description => "Uploaded new agent resource #{@agent_resource.id} - #{@agent_resource.name}.", :visible => true).save

				flash[:type] = "success"

				flash[:notice] = notice_message_created("agent resource")

				redirect_to(admin_agent_resources_url) and return
			else
				@item.delete_file

				flash[:type] = "error"

				flash[:notice] = error_message_could_not_save("agent resource")

				redirect_to(new_admin_agent_resource_url) and return
			end
		else
			flash[:type] = "error"

			flash[:notice] = error_message_could_not_create("agent resource")

			redirect_to(new_admin_agent_resource_url) and return
		end
	end

	def edit
		@agent_resource = AgentResource.find_by_id(params[:id])

		if @agent_resource.nil?
			flash[:type] = "error"

			flash[:notice] = error_message_could_not_find("agent resource")

			redirect_to(admin_agent_resources_url) and return
		end

		@page_title = "Edit Agent Resource - " + @agent_resource.name
	end

	def update
		@agent_resource = AgentResource.find_by_id(params[:id])

		if !@agent_resource.nil?
			if !params[:attachment].blank?
				result, message = AgentResource.validate_file_content_type(params[:attachment][:file])

				if result != true
					flash[:type] = "error"

					flash[:notice] = message

					redirect_to(edit_admin_agent_resource_url(@agent_resource)) and return
				end
			end

			if !@agent_resource.update_attributes(params[:agent_resource])
				flash[:error] = "error"

				flash[:notice] = error_message_could_not_update("picture")

				redirect_to(edit_admin_picture_url(@picture)) and return
			end

			if !params[:attachment].blank?
				result, message = @agent_resource.save_file(params[:attachment][:file])

				if result != true
					@agent_resource.delete_file

					flash[:type] = "error"

					flash[:notice] = message

					redirect_to(edit_admin_picture_url(@picture)) and return
				end
			end

			if @agent_resource.save
				LoggerEvent.new(:person_id => @user.id, :event_type => LoggerEvent::EventTypeObjectModified, :description => "Modified agent resource #{@agent_resource.id} - #{@agent_resource.name}.", :visible => true).save

				flash[:type] = "success"

				flash[:notice] = notice_message_updated("agent resource")

				redirect_to(admin_agent_resource_url(@agent_resource)) and return
			else
				flash[:type] = "error"

				flash[:notice] = error_message_could_not_save("agent resource")

				redirect_to(edit_admin_agent_resource_url(@agent_resource)) and return
			end
		else
			flash[:type] = "error"

			flash[:notice] = error_message_could_not_find("agent resource")

			redirect_to(admin_agent_resources_url) and return
		end
	end

	def destroy
		@agent_resource = AgentResource.find_by_id(params[:id])

		if !@agent_resource.nil?
			#this has to go first otherwise @picture will be undefined (I think)
			LoggerEvent.new(:person_id => @user.id, :ip_address => request.remote_ip, :event_type => LoggerEvent::EventTypeObjectDeleted, :description => "Deleted agent resource #{@agent_resource.id} - #{@agent_resource.name}.", :visible => true).save

			begin
				AgentResource.destroy(@agent_resource)
			rescue Exception => error
				flash[:type] = "error"

				flash[:notice] = error.message

				redirect_to(edit_admin_agent_resource_url(@agent_resource)) and return
			end

			flash[:type] = "success"

			flash[:notice] = notice_message_destroyed("agent resource")

			redirect_to(admin_agent_resources_url) and return
		else
			flash[:type] = "error"

			flash[:notice] = error_message_could_not_find("agent resource")

			redirect_to(admin_agent_resources_url) and return
		end
	end

	def get_file
		@agent_resource = AgentResource.find_by_id(params[:id])

		if @agent_resource.nil?
			flash[:type] = "error"

			flash[:notice] = error_message_could_not_find("agent resource")

			redirect_to(admin_root_url) and return
		end

		if @agent_resource.resource_filename.blank?
            flash[:type] = "error"

            flash[:notice] = "Error: This resource does not have a file attached to it!"

            redirect_to(admin_agent_resource_url(@agent_resource)) and return
		end

		send_file(File.join("private/uploads", @agent_resource.resource_filename))
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
		@agent_resources = AgentResource.find(params[:agent_resource_ids])

		for agent_resource in @agent_resources
			#we should use proper error control here, but since it's complicated
			#for now we'll use update_attributes! which will just throw an unhandled
			#exception if anything goes wrong.
			agent_resource.update_attributes!(params[:agent_resource].reject { |k, v| v.blank? })

			LoggerEvent.new(:person_id => @user.id, :ip_address => request.remote_ip, :event_type => LoggerEvent::EventTypeObjectModified, :description => "Modified agent resource #{agent_resource.id} - #{agent_resource.name}.", :visible => true).save
		end

		flash[:type] = "success"

		flash[:notice] = notice_message_updated("all agent resources")

		redirect_to(admin_agent_resources_url) and return
	end

	def destroy_multiple
		@agent_resources = AgentResource.find(params[:agent_resource_ids])

		for agent_resource in @agent_resources
			#this has to go first otherwise picture will be undefined (I think)
			LoggerEvent.new(:person_id => @user.id, :ip_address => request.remote_ip, :event_type => LoggerEvent::EventTypeObjectDeleted, :description => "Deleted agent resource #{agent_resource.id} - #{agent_resource.name}.", :visible => true).save

			begin
				AgentResource.destroy(agent_resource)
			rescue Exception => error
				flash[:type] = "error"

				flash[:notice] = error.message

				redirect_to(admin_agent_resources_url) and return
			end
		end

		flash[:type] = "success"

		flash[:notice] = notice_message_destroyed("all agent_resources")

		redirect_to(admin_pictures_url) and return
	end
end
