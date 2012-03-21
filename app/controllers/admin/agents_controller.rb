require "will_paginate"

class Admin::AgentsController < Admin::AdminController
	before_filter :is_admin?

	def index
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

			@agents = Agent.paginate(:page => params[:page], :per_page => per_page, :order => sort_order, :conditions => ['id LIKE ?', search])
		else
			@agents = Agent.paginate(:page => params[:page], :per_page => per_page, :order => sort_order)
		end

		@page_title = "Agents"

		if mobile_browser?
			render :action => "index_mobile"
		end
	end

	def show
		@agent = Agent.find_by_slug(params[:id])

		if @agent.nil?
			flash[:type] = "error"

			flash[:notice] = error_message_could_not_find("agent")

			redirect_to(admin_agents_url) and return
		end

		@page_title = "View Agent - " + @agent.person.first_name + " " + @agent.person.last_name

		if mobile_browser?
			render :action => "show_mobile"
		end
	end

	def new
		@agent = Agent.new

		@page_title = "New Agent"

		if mobile_browser?
			render :action => "new_mobile"
		end
	end

	def create
		@agent = Agent.new(params[:agent])

		if !@agent.nil?
			if !@agent.person_id.nil? and @agent.person.nil?
				flash[:type] = "error"

				flash[:notice] = "Error: Invalid user!"

				redirect_to(new_admin_agent_url) and return
			end

			if @agent.save
				LoggerEvent.new(:person_id => @user.id, :event_type => LoggerEvent::EventTypeObjectCreated, :description => "Created new agent #{@agent.id} - #{@agent.person.name}.", :visible => true).save

				flash[:type] = "success"

				flash[:notice] = notice_message_created("agent")

				redirect_to(admin_agent_url(@agent)) and return
			else
				flash[:type] = "error"

				flash[:notice] = format_error_messages(@agent.errors)

				redirect_to(new_admin_agent_url) and return
			end
		else
			flash[:type] = "error"

			flash[:notice] = error_message_could_not_create("agent")

			redirect_to(new_admin_agent_url) and return
		end
	end

	def edit
		@agent = Agent.find_by_slug(params[:id])

		if @agent.nil?
			flash[:type] = "error"

			flash[:notice] = error_message_could_not_find("agent")

			redirect_to(admin_agents_url) and return
		end

		if !@agent.person_id.nil? and @agent.person.nil?
			flash[:type] = "error"

			flash[:notice] = "Error: Invalid attached user!"

			redirect_to(admin_agents_url) and return
		end

		@page_title = "Edit Agent - " + @agent.person.name

		if mobile_browser?
			render :action => "edit_mobile"
		end
	end

	def update
		@agent = Agent.find_by_slug(params[:id])

		if !@agent.nil?
			if !@agent.person_id.nil? and @agent.person.nil?
				flash[:type] = "error"

				flash[:notice] = "Error: Invalid attached user!"

				redirect_to(admin_agents_url) and return
			end

			if @agent.update_attributes(params[:agent])
				LoggerEvent.new(:person_id => @user.id, :event_type => LoggerEvent::EventTypeObjectModified, :description => "Modified agent #{@agent.id} - #{@agent.person.name}.", :visible => true).save

				flash[:type] = "success"

				flash[:notice] = notice_message_updated("agent")
			else
				flash[:type] = "error"

				flash[:notice] = error_message_could_not_update("agent")
			end

			redirect_to(edit_admin_agent_url(@agent)) and return
		else
			flash[:type] = "error"

			flash[:notice] = error_message_could_not_find("agent")

			redirect_to(admin_agents_url) and return
		end
	end

	def destroy
		@agent = Agent.find_by_slug(params[:id])

		if !@agent.nil?
			#this has to go first otherwise page will be undefined (I think)
			LoggerEvent.new(:person_id => @user.id, :event_type => LoggerEvent::EventTypeObjectDeleted, :description => "Deleted agent #{@agent.id} - #{@agent.person.name}.", :visible => true).save

			Agent.destroy(@agent)

			flash[:type] = "success"

			flash[:notice] = notice_message_destroyed("agent")
		else
			flash[:type] = "error"

			flash[:notice] = error_message_could_not_find("agent")
		end

		redirect_to(admin_agents_url) and return
	end

	def update_multiple

	end

	def destroy_multiple

	end
end
