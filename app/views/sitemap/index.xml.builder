xml.instruct!
xml.urlset :xmlns => 'http://www.sitemaps.org/schemas/sitemap/0.9' do
	xml.url do
		xml.loc root_url
		xml.lastmod "2011-04-01T00:00:01-06:00"
		xml.changefreq "monthly"
	end
	@pages.each do |page|
		xml.url do
			xml.loc page_url(page)
			xml.lastmod page.updated_at.xmlschema
			xml.changefreq "monthly"
		end
	end
	xml.url do
		xml.loc agents_url
		xml.lastmod @agents.last.updated_at.xmlschema
		xml.changefreq "monthly"
	end
	@agents.each do |agent|
		xml.url do
			xml.loc page_url(agent)
			xml.lastmod agent.updated_at.xmlschema
			xml.changefreq "monthly"
		end
	end
	xml.url do
		xml.loc blogs_url
		xml.lastmod @blogs.last.updated_at.xmlschema
		xml.changefreq "daily"
	end
	@blogs.each do |blog|
		xml.url do
			xml.loc blog_url(blog)
			xml.lastmod blog.updated_at.xmlschema
			xml.changefreq "daily"
		end
	end
end
