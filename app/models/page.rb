class Page < ActiveRecord::Base
	has_many :subpages, :class_name => "Page", :foreign_key => "parent_id", :dependent => :destroy, :order => "display_order"

	belongs_to :parent, :class_name => "Page"

	has_many :pictures, :as => :attachable

	validates_presence_of :title, :body, :display_order

	before_save :create_slug

	def to_param
		self.slug
	end

	def create_slug
		if self.title.blank?
			self.slug = self.id
		else
			self.slug = "#{self.title.downcase.gsub(/[^[:alnum:]]/,'-')}".gsub(/-{2,}/,'-')
		end
	end

	def bump_display_order
		siblings = Page.find_all_by_parent_id(self.parent_id)

		#should probably combine this into one delete_if
		#but for now we'll leave it broken apart for clarity's sake

		siblings.delete_if {|page| page == self}

		siblings.delete_if {|page| page.display_order < self.display_order}

		siblings.each do |page|
			page.display_order += 1

			page.save
		end
	end

	def make_index_page
		pages = Page.find(:all, :conditions => ["is_index = ?", 1])

		pages.delete_if {|page| page == self}

		pages.each do |page|
			page.is_index = 0

			page.save
		end
	end

	def get_dropdown_title
		number_of_levels = 0

		dropdown_title = ""

		current = self

		while current != nil and current.parent != nil
			number_of_levels += 1

			dropdown_title += "-"

			current = current.parent
		end

		if number_of_levels == 0
			dropdown_title = self.title
		else
			dropdown_title += " " + self.title
		end

		return dropdown_title
	end
end
