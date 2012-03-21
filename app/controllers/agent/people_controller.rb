require "will_paginate"

class Agent::PeopleController < Agent::AgentController
	def edit
		@person = Person.find_by_id(params[:id])

		if @person.nil?
			flash[:type] = "error"

			flash[:notice] = error_message_could_not_find("person")

			redirect_to(agent_root_url) and return
		end

		if @user.privilege_level < 4 and @user != @person or @user.privilege_level < @person.privilege_level
			flash[:type] = "attention"

			flash[:notice] = "Error: You are not authorized to edit that account."

			redirect_to(agent_root_url) and return
		end

		@page_title = "Account Settings"

		if mobile_browser?
			render :action => "edit_mobile"
		end
	end

	def update
		@person = Person.find_by_id(params[:id])

		if !@person.nil?
			if @user.privilege_level < 4 and @user != @person or @user.privilege_level < @person.privilege_level
				flash[:type] = "attention"

				flash[:notice] = "Error: You are not authorized to edit that account."

				redirect_to(agent_root_url) and return
			end

			if @person.update_attributes(params[:person])
				LoggerEvent.new(:person_id => @user.id, :ip_address => request.remote_ip, :event_type => LoggerEvent::EventTypeObjectModified, :description => "Modified user #{@person.id} - #{@person.name}.", :visible => true).save

				flash[:type] = "success"

				flash[:notice] = notice_message_updated("your account")
			else
				flash[:type] = "error"

				flash[:notice] = format_error_messages(@person.errors)
			end

			redirect_to(edit_agent_person_url(@person)) and return
		else
			flash[:type] = "error"

			flash[:notice] = error_message_could_not_find("person")

			redirect_to(agent_root_url) and return
		end
	end
end
