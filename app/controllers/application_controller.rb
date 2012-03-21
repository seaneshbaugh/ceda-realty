require "messages"
require "textmodule"

class ApplicationController < ActionController::Base
	include Messages
	include TextModule

	helper :all # include all helpers, all the time

	# See ActionController::RequestForgeryProtection for details
	# Uncomment the :secret if you're not using the cookie session store
	protect_from_forgery # :secret => '6d2c43d36cc62847e442e47897713880'

	layout :get_layout

	before_filter :maintain_session_and_user, :get_top_level_pages

	def maintain_session_and_user
		if session[:id]
			if @application_session = Session.find_by_id(session[:id])
				@application_session.update_attributes(:ip_address => request.remote_addr, :path => request.path_info)

				@user = @application_session.person
			else
				session[:id] = nil

				redirect_to(root_url) and return
			end
		else
			if !cookies[:remember_me_id].nil?
				@user = Person.find_by_id(cookies[:remember_me_id])

				if !@user.nil?
					if cookies[:remember_me_code] == Digest::SHA256.hexdigest(@user.cookie_code)
						@session = @user.sessions.create

						LoggerEvent.new(:person => @session.person, :event_type => LoggerEvent::EventTypeLogin, :description => "#{@session.person.name} has logged in from #{request.remote_ip}.", :visible => true).save

						session[:id] = @session.id

						if @application_session = Session.find_by_id(session[:id])
							@application_session.update_attributes(:ip_address => request.remote_addr, :path => request.path_info)

							@user = @application_session.person

							@user.last_login = Time.now

							@user.save
						else
							session[:id] = @user = nil

							cookies.delete :remember_me_id

							cookies.delete :remember_me_code

							redirect_to(root_url) and return
						end
					else
						cookies.delete :remember_me_id

						cookies.delete :remember_me_code
					end
				else
					cookies.delete :remember_me_id

					cookies.delete :remember_me_code
				end
			end
		end
	end

	def ensure_login
		unless @user
			redirect_to(root_url) and return
		end
	end

	def ensure_logout
		if @user
			redirect_to(root_url) and return
		end
	end

	def is_agent?
		if @user.nil?
			flash[:type] = "attention"

			flash[:notice] = "You must be logged in to view this page."

			redirect_to(root_url) and return
		end

		if @user.privilege_level < Person::PrivilegeLevelAgent
			flash[:type] = "attention"

			flash[:notice] = "You are not authorized to view this page."

			redirect_to(:back) and return
		end
	end

	def is_moderator?
		if @user.nil?
			flash[:type] = "attention"

			flash[:notice] = "You must be logged in to view this page."

			redirect_to(root_url) and return
		end

		if @user.privilege_level < Person::PrivilegeLevelModerator
			flash[:type] = "attention"

			flash[:notice] = "You are not authorized to view this page."

			redirect_to(:back) and return
		end
	end

	def is_admin?
		if @user.nil?
			flash[:type] = "attention"

			flash[:notice] = "You must be logged in to view this page."

			redirect_to(root_url) and return
		end

		if @user.privilege_level < Person::PrivilegeLevelAdmin
			#Since this should only be run on admin pages if the user is an
			#agent and they try and view an admin page we want to silently
			#redirect them to the agent index page. This way we only have
			#one link on the front end and one bookmark for the agents.
			#This also makes going to the agent view easy for admins.
			if @user.privilege_level == Person::PrivilegeLevelAgent
				redirect_to(agent_root_url) and return
			end

			flash[:type] = "attention"

			flash[:notice] = "You are not authorized to view this page."

			redirect_to(:back) and return
		end
	end

	def is_sysop?
		if @user.nil?
			flash[:type] = "attention"

			flash[:notice] = "You must be logged in to view this page."

			redirect_to(root_url) and return
		end

		if @user.privilege_level < Person::PrivilegeLevelSysOp
			flash[:type] = "attention"

			flash[:notice] = "You are not authorized to view this page."

			redirect_to(:back) and return
		end
	end

	def mobile_browser?
		request.env["HTTP_USER_AGENT"] && request.env["HTTP_USER_AGENT"][/(iPhone|iPod|iPad|Android)/]
	end
	helper_method :mobile_browser?

	def get_layout
		if mobile_browser?
			#change to "application_mobile" when the mobile layout is done
			return "application"
		else
			return "application"
		end
	end

	def get_top_level_pages
		@top_level_pages = Page.find_all_by_parent_id(nil, :order => "display_order")
	end
end
