require "will_paginate"

class Agent::AgentsController < Agent::AgentController
	def edit
		@agent = Agent.find_by_slug(params[:id])

		if @agent.nil?
			flash[:type] = "error"

			flash[:notice] = error_message_could_not_find("agent bio")

			redirect_to(agent_agents_url) and return
		end

		if !@agent.person_id.nil? and @agent.person.nil?
			flash[:type] = "error"

			flash[:notice] = "Error: Invalid attached user!"

			redirect_to(agent_agents_url) and return
		end

		if @user.privilege_level < 4 and @user.agent != @agent or @user.privilege_level < @agent.person.privilege_level
			flash[:type] = "attention"

			flash[:notice] = "Error: You are not authorized to edit that agent bio."

			redirect_to(agent_root_url) and return
		end

		@page_title = "Your Agent Bio"
	end

	def update
		@agent = Agent.find_by_slug(params[:id])

		if !@agent.nil?
			if @user.privilege_level < 4 and @user.agent != @agent or @user.privilege_level < @agent.person.privilege_level
				flash[:type] = "attention"

				flash[:notice] = "Error: You are not authorized to edit that agent bio."

				redirect_to(agent_root_url) and return
			end

			if !@agent.person_id.nil? and @agent.person.nil?
				flash[:type] = "error"

				flash[:notice] = "Error: Invalid attached user!"

				redirect_to(agent_agents_url) and return
			end

			if @agent.update_attributes(params[:agent])
				LoggerEvent.new(:person_id => @user.id, :ip_address => request.remote_ip, :event_type => LoggerEvent::EventTypeObjectModified, :description => "Modified agent #{@agent.id} - #{@agent.person.name}.", :visible => true).save

				flash[:type] = "success"

				flash[:notice] = notice_message_updated("your agent bio")
			else
				flash[:type] = "error"

				flash[:notice] = error_message_could_not_update("your agent bio")
			end

			redirect_to(edit_agent_agent_url(@agent)) and return
		else
			flash[:type] = "error"

			flash[:notice] = error_message_could_not_find("agent bio")

			redirect_to(agent_agents_url) and return
		end
	end
end
