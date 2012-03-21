class Agent < ActiveRecord::Base
	belongs_to :person
	belongs_to :picture

	before_save :create_slug

	def to_param
		self.slug
	end

	def create_slug
		if self.person.nil? or self.person_id.nil?
			self.slug = self.id
		else
			if self.person.first_name.blank? or self.person.last_name.blank?
				self.slug = self.id
			else
				self.slug = "#{self.person.first_name.downcase.gsub(/[^[:alnum:]]/,'-')}-#{self.person.last_name.downcase.gsub(/[^[:alnum:]]/,'-')}".gsub(/-{2,}/,'-')
			end
		end
	end

	def <=>(other)
		if self.person.last_name < other.person.last_name
			return -1
		end

		if self.person.last_name > other.person.last_name
			return 1
		end

		if self.person.first_name < other.person.first_name
			return -1
		end

		if self.person.first_name > other.person.first_name
			return 1
		end

		return 0
	end

	def has_designations?
		if self.abr_designation or self.abrm_designation or self.alc_designation or self.cips_designation or self.epro_designation or self.green_designation or self.gri_designation or self.ahwd_designation or self.repa_designation or self.rsps_designation or self.sres_designation or self.sfr_designation or self.tahs_designation or self.trc_designation or self.ihlm_designation or self.ccim_designation or self.cpm_designation or self.crb_designation or self.cre_designation or self.crs_designation or self.gaa_designation or self.pmn_designation or self.rce_designation or self.raa_designation or self.sior_designation
			return true
		else
			return false
		end
	end
end
