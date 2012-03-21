require "will_paginate"

class Admin::PeopleController < Admin::AdminController
	before_filter :is_admin?, :except => [:edit, :update]

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

			@people = Person.paginate(:page => params[:page], :per_page => per_page, :order => sort_order, :conditions => ['name LIKE ?', search])
		else
			@people = Person.paginate(:page => params[:page], :per_page => per_page, :order => sort_order)
		end

		@page_title = "Users"

		if mobile_browser?
			render :action => "index_mobile"
		end
	end

	def show
		@person = Person.find_by_id(params[:id])

		if @person.nil?
			flash[:type] = "error"

			flash[:notice] = error_message_could_not_find("person")

			redirect_to(admin_people_url) and return
		end

		@page_title = "View User - " + @person.name

		if mobile_browser?
			render :action => "show_mobile"
		end
	end

	def new
		@person = Person.new

		@page_title = "New User"

		if mobile_browser?
			render :action => "new_mobile"
		end
	end

	def create
		@person = Person.new(params[:person])

		if !@person.nil?
			@person.generate_cookie_code

			if @person.save
				LoggerEvent.new(:person_id => @user.id, :event_type => LoggerEvent::EventTypeObjectCreated, :description => "Created new user #{@person.id} - #{@person.name}.", :visible => true).save

				flash[:type] = "success"

				flash[:notice] = notice_message_created("User " + @person.name)

				redirect_to(admin_root_url) and return
			else
				flash[:type] = "error"

				flash[:notice] = format_error_messages(@person.errors)

				redirect_to(new_admin_person_url) and return
			end
		else
			flash[:type] = "error"

			flash[:notice] = error_message_could_not_create("person")

			redirect_to(new_admin_person_url) and return
		end
	end

	def edit
		@person = Person.find_by_id(params[:id])

		if @person.nil?
			flash[:type] = "error"

			flash[:notice] = error_message_could_not_find("person")

			redirect_to(admin_people_url) and return
		end

		if @user.privilege_level < 4 and @user != @person or @user.privilege_level < @person.privilege_level
			flash[:type] = "attention"

			flash[:notice] = "Error: You are not authorized to edit that account."

			redirect_to(:back) and return
		end

		@page_title = "Edit User - " + @person.name

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

				redirect_to(admin_root_url) and return
			end

			if @person.update_attributes(params[:person])
				LoggerEvent.new(:person_id => @user.id, :event_type => LoggerEvent::EventTypeObjectModified, :description => "Modified user #{@person.id} - #{@person.name}.", :visible => true).save

				flash[:type] = "success"

				flash[:notice] = notice_message_updated(make_possessive(@person.name) + " account")
			else
				flash[:type] = "error"

				flash[:notice] = format_error_messages(@person.errors)
			end

			redirect_to(edit_admin_person_url(@person)) and return
		else
			flash[:type] = "error"

			flash[:notice] = error_message_could_not_find("person")

			redirect_to(admin_people_url) and return
		end
	end

	def destroy
		@person = Person.find_by_id(params[:id])

		if !@person.nil?
			if @person == @user
				#this has to go first otherwise @person will be undefined (I think)
				LoggerEvent.new(:person_id => @user.id, :event_type => LoggerEvent::EventTypeObjectDeleted, :description => "Deleted user #{@person.id} - #{@person.name}.", :visible => true).save

				Person.destroy(@person)

				session[:id] = @user = nil


				flash[:type] = "success"

				flash[:notice] = "Your account has been deleted!"

				redirect_to(root_url) and return
			else
				if @user.privilege_level > @person.privilege_level
					#this has to go first otherwise @person will be undefined (I think)
					LoggerEvent.new(:person_id => @user.id, :event_type => LoggerEvent::EventTypeObjectDeleted, :description => "Deleted user #{@person.id} - #{@person.name}.", :visible => true).save

					Person.destroy(@person)

					flash[:type] = "success"

					flash[:notice] = notice_message_destroyed("person")

					redirect_to(admin_people_url) and return
				else
					flash[:type] = "error"

					flash[:notice] = "You do not have permission to delete this account."

					redirect_to(admin_people_url) and return
				end
			end
		else
			flash[:type] = "error"

			flash[:notice] = error_message_could_not_find("person")

			redirect_to(admin_people_url) and return
		end
	end

	def edit_multiple
		@people = Person.find(params[:people_ids])

		if @people.nil?
			flash[:type] = "error"

			flash[:notice] = error_message_could_not_find("one or more of the selected users")

			redirect_to(admin_people_url) and return
		end

		@page_title = "Edit Multiple Users"
	end

	def update_multiple
		@people = Person.find(params[:people_ids])

		for person in @people
			#we should use proper error control here, but since it's complicated
			#for now we'll use update_attributes! which will just throw an unhandled
			#exception if anything goes wrong.
			person.update_attributes!(params[:person].reject { |k, v| v.blank? })

			LoggerEvent.new(:person_id => @user.id, :event_type => LoggerEvent::EventTypeObjectModified, :description => "Modified user #{person.id} - #{person.name}.", :visible => true).save
		end

		flash[:type] = "success"

		flash[:notice] = notice_message_updated("all users")

		redirect_to(admin_people_url) and return
	end

	def destroy_multiple
		@people = Person.find(params[:people_ids])

		for person in @posts
			#this has to go first otherwise person will be undefined (I think)
			LoggerEvent.new(:person_id => @user.id, :event_type => LoggerEvent::EventTypeObjectDeleted, :description => "Deleted user #{person.id} - #{person.name}.", :visible => true).save

			Person.destroy(person)
		end

		flash[:type] = "success"

		flash[:notice] = notice_message_destroyed("all users")

		redirect_to(admin_people_url) and return
	end
end
