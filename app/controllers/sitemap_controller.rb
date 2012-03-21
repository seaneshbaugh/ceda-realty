class SitemapController < ApplicationController
	layout nil

	def index
		headers["Content-Type"] = "application/xml"

		latest = Page.find(:all, :limit => 1, :order => 'created_at DESC').last

		#if stale?(:etag => latest, :last_modified => latest.updated_at.utc)
			respond_to do |format|
				format.xml { @pages = Page.find(:all, :limit => 16666, :order => 'created_at DESC')
							 @blogs = Blog.find(:all, :limit => 16666, :order => 'created_at DESC')
							 @agents = Agent.find(:all, :limit => 16666, :order => 'created_at DESC')

							}
			end
		#end
	end
end
