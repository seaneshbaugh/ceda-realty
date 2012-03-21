require "will_paginate"

class Admin::BlogsController < Admin::AdminController
	before_filter :is_admin?

	def index
		per_page = params[:per_page]

		per_page ||= 25

		params[:submit] = nil

		if !params[:sort].nil? and !params[:order].nil?
			sort_order = params[:sort].to_s + " " + params[:order].to_s
		else
			sort_order = "created_at DESC"
		end

		if !params[:search].blank?
			search = "%" + params[:search] + "%"

			@blogs = Blog.paginate(:page => params[:page], :per_page => per_page, :order => sort_order, :conditions => ['title LIKE ?', search])
		else
			@blogs = Blog.paginate(:page => params[:page], :per_page => per_page, :order => sort_order)
		end

		@page_title = "Blog Posts"

		if mobile_browser?
			render :action => "index_mobile"
		end
	end

	def show
		@blog = Blog.find_by_id(params[:id])

		if @blog.nil?
			flash[:type] = "error"

			flash[:notice] = error_message_could_not_find("blog post")

			redirect_to(admin_blogs_url) and return
		end

		@page_title = "View Blog Post- " + @blog.title

		if mobile_browser?
			render :action => "show_mobile"
		end
	end

	def new
		@blog = Blog.new

		@pictures = Picture.find(:all)

		@page_title = "New Blog Post"

		if mobile_browser?
			render :action => "new_mobile"
		end
	end

	def create
		@blog = Blog.new(params[:blog])

		if !@blog.nil?
			@blog.person_id = @user.id

			if @blog.save
				LoggerEvent.new(:person_id => @user.id, :event_type => LoggerEvent::EventTypeObjectCreated, :description => "Created new blog post #{@blog.id} - #{@blog.title}.", :visible => true).save

				flash[:type] = "success"

				flash[:notice] = notice_message_created("blog post")

				redirect_to(admin_blog_url(@blog)) and return
			else
				flash[:type] = "error"

				flash[:notice] = format_error_messages(@blog.errors)

				redirect_to(new_admin_blog_url) and return
			end
		else
			flash[:type] = "error"

			flash[:notice] = error_message_could_not_create("blog post")

			redirect_to(new_admin_blog_url) and return
		end
	end

	def edit
		@blog = Blog.find_by_id(params[:id])

		if @blog.nil?
			flash[:type] = "error"

			flash[:notice] = error_message_could_not_find("blog post")

			redirect_to(admin_blogs_url) and return
		end

		@pictures = Picture.find(:all)

		@blog_title = "Edit Blog Post - " + @blog.title

		if mobile_browser?
			render :action => "edit_mobile"
		end
	end

	def update
		@blog = Blog.find_by_id(params[:id])

		if !@blog.nil?
			if @blog.update_attributes(params[:blog])
				LoggerEvent.new(:person_id => @user.id, :event_type => LoggerEvent::EventTypeObjectModified, :description => "Modified blog post #{@blog.id} - #{@blog.title}.", :visible => true).save

				flash[:type] = "success"

				flash[:notice] = notice_message_updated("blog post")
			else
				flash[:type] = "error"

				flash[:notice] = error_message_could_not_update("blog post")
			end

			redirect_to(edit_admin_blog_url(@blog)) and return
		else
			flash[:type] = "error"

			flash[:notice] = error_message_could_not_find("blog post")

			redirect_to(admin_blogs_url) and return
		end
	end

	def destroy
		@blog = Blog.find_by_id(params[:id])

		if !@blog.nil?
			#this has to go first otherwise blog will be undefined (I think)
			LoggerEvent.new(:person_id => @user.id, :event_type => LoggerEvent::EventTypeObjectDeleted, :description => "Deleted blog post #{@blog.id} - #{@blog.title}.", :visible => true).save

			Blog.destroy(@blog)

			flash[:type] = "success"

			flash[:notice] = notice_message_destroyed("blog post")
		else
			flash[:type] = "error"

			flash[:notice] = error_message_could_not_find("blog post")
		end

		redirect_to(admin_blogs_url) and return
	end

	def edit_multiple
		#@blogs = Blog.find(params[:blog_ids])
		@blogs = HierarchySorter.new(Blog.find(params[:blog_ids])).sorted_array

		if @blogs.nil?
			flash[:type] = "error"

			flash[:notice] = error_message_could_not_find("one or more of the selected blog posts")

			redirect_to(admin_blogs_url) and return
		end

		@blog_title = "Edit Multiple Blog Posts"
	end

	def update_multiple
		@blogs = Blog.find(params[:blog_ids])

		for blog in @blogs
			#we should use proper error control here, but since it's complicated
			#for now we'll use update_attributes! which will just throw an unhandled
			#exception if anything goes wrong.
			blog.update_attributes!(params[:blog].reject { |k, v| v.blank? })

			LoggerEvent.new(:person_id => @user.id, :event_type => LoggerEvent::EventTypeObjectModified, :description => "Modified blog post #{blog.id} - #{blog.title}.", :visible => true).save
		end

		flash[:type] = "success"

		flash[:notice] = notice_message_updated("all blog posts")

		redirect_to(admin_blogs_url) and return
	end

	def destroy_multiple
		@blogs = Blog.find(params[:blog_ids])

		for blog in @blogs
			#this has to go first otherwise blog will be undefined (I think)
			LoggerEvent.new(:person_id => @user.id, :event_type => LoggerEvent::EventTypeObjectDeleted, :description => "Deleted blog post #{blog.id} - #{blog.title}.", :visible => true).save

			Blog.destroy(blog)
		end

		flash[:type] = "success"

		flash[:notice] = notice_message_destroyed("all blog posts")

		redirect_to(admin_blogs_url) and return
	end
end
