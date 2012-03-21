require "will_paginate"

class Agent::AgentResourcesController < Agent::AgentController
	def index
		per_page = params[:per_page]

		per_page ||= 25

		params[:submit] = nil

		if !params[:sort].nil? and !params[:order].nil?
			sort_order = params[:sort].to_s + " " + params[:order].to_s
		else
			sort_order = "name ASC"
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

			flash[:notice] = error_message_could_not_find("resource")

			redirect_to(agent_root_url) and return
		end

		@agent_resources = AgentResource.find_all_by_name_and_category(@agent_resource.name, @agent_resource.category)

		@page_title = @agent_resource.name

		if mobile_browser?
			render :action => "show_mobile"
		end
	end

	def new
		@agent_resource = AgentResource.new

		@page_title = "New Resource"

		if mobile_browser?
			render :action => "new_mobile"
		end
	end

	def create
		if params[:attachment].blank? and params[:agent_resource][:external_url].blank?
			flash[:type] = "error"

			flash[:notice] = "Error: No file uploaded or external URL specified."

			redirect_to(new_agent_agent_resource_url) and return
		end

		if !params[:attachment].blank? and !params[:agent_resource][:external_url].blank?
			flash[:type] = "error"

			flash[:notice] = "Error: You cannot upload a file and specify an external URL."

			redirect_to(new_agent_agent_resource_url) and return
		end

		@agent_resource = AgentResource.new(params[:agent_resource])

		@agent_resource.person = @user

		if !@agent_resource.nil?
			if !params[:attachment].blank?
				result, message = @agent_resource.save_file(params[:attachment][:file])

				if result != true
					@agent_resource.delete_file

					flash[:type] = "error"

					flash[:notice] = message

					redirect_to(new_agent_agent_resource_url) and return
				end
			end

			if @agent_resource.save
				LoggerEvent.new(:person_id => @user.id, :event_type => LoggerEvent::EventTypeObjectCreated, :description => "Uploaded new agent resource #{@agent_resource.id} - #{@agent_resource.name}.", :visible => true).save

				flash[:type] = "success"

				flash[:notice] = notice_message_created("resource")

				redirect_to(agent_agent_resources_url) and return
			else
				@item.delete_file

				flash[:type] = "error"

				flash[:notice] = error_message_could_not_save("agent resource")

				redirect_to(new_agent_agent_resource_url) and return
			end
		else
			flash[:type] = "error"

			flash[:notice] = error_message_could_not_create("resource")

			redirect_to(new_agent_agent_resource_url) and return
		end
	end

	def get_file
		@agent_resource = AgentResource.find_by_id(params[:id])

		if @agent_resource.nil?
			flash[:type] = "error"

			flash[:notice] = error_message_could_not_find("agent resource")

			redirect_to(agent_root_url) and return
		end

		if @agent_resource.resource_filename.blank?
            flash[:type] = "error"

            flash[:notice] = "Error: This resource does not have a file attached to it."

            redirect_to(agent_resource_url(@agent_resource)) and return
		end

		send_file(File.join("private/uploads", @agent_resource.resource_filename))
	end
end
