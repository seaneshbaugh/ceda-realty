require "digest/sha2"

class SessionsController < ApplicationController
	before_filter :ensure_login, :only => :destroy
	before_filter :ensure_logout, :only => [:new, :create, :recovery]

	def new
		@session = Session.new
	end

	def create
		@session = Session.new(params[:session])

		if !@session.nil?
			if @session.save
				session[:id] = @session.id

				#if the session has been saved and we've stored the session
				#id in the session hash we want to then attempt to store the
				#users IP address in the database.

				#get the user associated with this session
				user = @session.person

				user.update_ip_log(request.remote_ip)

				#if the remember_me option was selected
				if params[:remember_me] == "1"
					#if the user's cookie_code field is blank generate a
					#cookie code for them. this should happen when a user
					#is created, but just in case we do it anyways. the
					#cookie code is also reset if the limit_session param
					#is present. what this does is basically invalidate
					#any other remember_me cookies for this user. because
					#when an attempt at auto-logging in is made the
					#encrypted code in the cookie will not match the code
					#in the database when it is encrypted.
					if user.cookie_code.blank? or params[:limit_session] == "1"
						user.generate_cookie_code
					end

					#set a cookie with the user's ID
					cookies[:remember_me_id] = { :value => user.id.to_s, :expires => 365.days.from_now }

					#set a cookie with a hash of the user's cookie_code
					cookies[:remember_me_code] = { :value => Digest::SHA256.hexdigest(user.cookie_code), :expires => 365.days.from_now }
				end

				#update the last login time
				user.last_login = Time.now

				if user.login_count.nil?
					user.login_count = 0
				end

				user.login_count += 1

				#save the user to the database
				user.save

				flash[:type] = "success"

				flash[:notice] = "Welcome back " + @session.person.name + ", thank you for logging in!"

				redirect_to(root_url) and return
			else
				flash[:type] = "error"

				flash[:notice] = error_message_could_not_save("login session")

				redirect_to(new_session_url) and return
			end
		else
			flash[:type] = "error"

			flash[:notice] = error_message_could_not_create("session")

			redirect_to(new_session_url) and return
		end
	end

	def destroy
		Session.destroy(@application_session)

		session[:id] = @user = nil

		if !cookies[:remember_me_id].nil?
			cookies.delete :remember_me_id
		end

		if !cookies[:remember_me_code].nil?
			cookies.delete :remember_me_code
		end

		flash[:type] = "information"

		flash[:notice] = "You are now logged out."

		redirect_to(root_url) and return
	end

	def recovery
		begin
			key = Crypto.decrypt(params[:id]).split(/:/)

			@session = Person.find(key[0], :conditions => {:salt => key[1]}).sessions.create

			session[:id] = @session.id

			flash[:type] = "attention"

			flash[:notice] = "Please change your password."

			redirect_to(root_url) and return
		rescue ActiveRecord::RecordNotFound
			flash[:type] = "error"

			flash[:notice] = "Invalid recovery link."

			redirect_to(new_session_url) and return
		end
	end
end
