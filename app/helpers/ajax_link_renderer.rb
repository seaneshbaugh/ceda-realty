require "will_paginate"

class AjaxLinkRenderer < WillPaginate::LinkRenderer
protected
	def page_link(page, text, attributes = {})
		@template.link_to text, nil, :onclick => "return loadpage('#{url_for(page)}');"
	end
end
