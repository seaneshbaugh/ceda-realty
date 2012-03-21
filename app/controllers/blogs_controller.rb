require "will_paginate"

class BlogsController < ApplicationController
	def index
		per_page = params[:per_page]

		per_page ||= 25

		params[:submit] = nil

		@blogs = Blog.paginate(:page => params[:page], :per_page => per_page, :order => "created_at DESC")

		@page_title = "Blog"
	end

	def show
		@blog = Blog.find_by_id(params[:id])

		if @blog.nil?
			flash[:type] = "error"

			flash[:notice] = error_message_could_not_find("blog post")

			redirect_to(root_url) and return
		end

		all_blogs = Blog.find(:all, :order => 'created_at DESC')

		blog_index = all_blogs.index(@blog)

		@back_page_number = (blog_index / 25) + 1

		if !@blog.meta_description.blank?
			@meta_description = @blog.meta_description
		else
			@meta_description = "A blog post about " + @blog.title + " brought to you by Ceda Realty."
		end

		@page_title = @blog.title
	end
end
