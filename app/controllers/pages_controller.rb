class PagesController < ApplicationController
	def index
		@pages = Page.find(:all, :conditions => ["parent_id = ?", nil])

		@index_page = Page.find(:first, :conditions => ["is_index = ?", 1])
	end

	def show
		@page = Page.find_by_slug(params[:id])

		if @page.nil?
			flash[:type] = "error"

			flash[:notice] = error_message_could_not_find("page")

			redirect_to(root_url) and return
		end

		@page_title = @page.title
	end
end
