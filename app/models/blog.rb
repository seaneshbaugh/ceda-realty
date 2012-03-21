class Blog < ActiveRecord::Base
	belongs_to :person

	validates_presence_of :title, :body

	def to_param
		"#{id}-#{title.parameterize}"
	end
end
