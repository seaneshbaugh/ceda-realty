class Listing < ActiveRecord::Base
	has_many :pictures, :as => :attachable

	def bump_display_order
		listings = Listing.find(:all)

		listings.delete_if {|listing| listing == self}

		listings.delete_if {|listing| listing.display_order < self.display_order}

		listings.each do |listing|
			listing.display_order += 1

			listing.save
		end
	end

	def id_with_street_address
		return self.id.to_s + ": " + self.street_address
	end

	def import_attributes_from_mls(mls_number)
		result = Net::HTTP.get(URI.parse("http://www.cedarealty.idxco.com/idx/9610/details.php?idxID=074&listingID=" + mls_number.to_s))

		doc = Nokogiri::HTML(result)

		node = doc.xpath("//div[@id='IDX-main']").first

		if node.inner_html.include?("The property you tried to view does not seem to exist.")
			return false
		end

		doc.at_css("body").traverse do |node|
			if node.text?
				new_text = node.content.strip
				node.send(:native_content=, new_text)
			end
		end

		node = doc.xpath("//div[@class='IDX-detailsAddressBox']").first

		#street_address
		self.street_address = node.inner_html.strip.split("<br>").first

		node = doc.xpath("//div[@class='IDX-detailsRemarks']").first

		#description
		self.description = node.inner_html.strip

		node = doc.xpath("//span[@id='IDX-priceNumber']").first

		#price
		self.price = node.inner_html.strip.delete(",")

		node = doc.xpath("//div[@class='IDX-detailsBasicLeft']").first

		basic_details_left = node.inner_html.split("<br>")

		#acres
		self.acres = basic_details_left[0].split(": ")[1]

		#area
		self.area = basic_details_left[1].split(": ")[1]

		#city
		self.city = basic_details_left[2].split(": ")[1]

		#county
		self.county = basic_details_left[3].split(": ")[1]

		#neighborhood
		self.neighborhood = basic_details_left[4].split(": ")[1]

		#schools
		self.schools = basic_details_left[5].split(": ")[1]

		#state
		self.state = basic_details_left[6].split(": ")[1]

		#sub_area
		self.sub_area = basic_details_left[7].split(": ")[1]

		node = doc.xpath("//div[@class='IDX-detailsBasicRight']").first

		basic_details_right = node.inner_html.split("<br>")

		#subdivision
		self.subdivision = basic_details_right[0].split(": ")[1]

		#type
		self.type = basic_details_right[1].split(": ")[1]

		#zipcode
		self.zipcode = basic_details_right[2].split(": ")[1]

		#number_of_full_bathrooms
		self.number_of_full_bathrooms = basic_details_right[3].split(": ")[1]

		#number_of_bedrooms
		self.number_of_bedrooms = basic_details_right[4].split(": ")[1]

		#number_of_half_bathrooms
		self.number_of_half_bathrooms = basic_details_right[5].split(": ")[1]

		#square_feet
		self.square_feet = basic_details_right[6].split(": ")[1]

		#node = doc.xpath("//div[@class='IDX-detailsAdvancedLeft']").first

		#advanced_details_left = node.inner_html.split("<br>")

		##alarm_security_type
		#self.alarm_security_type = advanced_details_left[1].split(": ")[1]

		##backyard_pool_features
		#self.backyard_pool_features = advanced_details_left[2].split(": ")[1]

		##bedroom_2_dimensions
		#self.bedroom_2_dimensions = advanced_details_left[3].split(": ")[1]

		##bedroom_3_dimensions
		#self.bedroom_3_dimensions = advanced_details_left[4].split(": ")[1]

		##bedroom_4_dimensions
		#self.bedroom_4_dimensions = advanced_details_left[5].split(": ")[1]

		##bedroom_5_dimensions

		##bedroom_6_dimensions

		##bedroom_7_dimensions

		##bedroom_8_dimensions

		##bedroom_9_dimensions

		##bedroom_10_dimensions

		##bed_bath_features
		#self.bed_bath_features = advanced_details_left[6].split(": ")[1]

		##construction
		#self.construction = advanced_details_left[7].split(": ")[1]

		##construction_status
		#self.construction_status = advanced_details_left[8].split(": ")[1]

		##directions
		#self.directions = advanced_details_left[9].split(": ")[1]

		##energy_efficiency
		#self.energy_efficiency = advanced_details_left[10].split(": ")[1]

		##exterior_features
		#self.exterior_features = advanced_details_left[11].split(": ")[1]

		##fireplace_type
		#self.fireplace_type = advanced_details_left[12].split(": ")[1]

		##flooring
		#self.flooring = advanced_details_left[13].split(": ")[1]

		##foundation
		#self.foundation = advanced_details_left[14].split(": ")[1]

		##garage_dimensions
		#self.garage_dimensions = advanced_details_left[15].split(": ")[1]

		##handicap_accessible
		#self.handicap_accessible = advanced_details_left[16].split(": ")[1]

		##heating_and_cooling
		#self.heating_and_cooling = advanced_details_left[17].split(": ")[1]

		##hoa
		#self.hoa = advanced_details_left[18].split(": ")[1]

		##housing_type
		#self.housing_type = advanced_details_left[19].split(": ")[1]

		##interior_features
		#self.interior_features = advanced_details_left[20].split(": ")[1]

		##kitchen_equipment
		#self.kitchen_equipment = advanced_details_left[21].split(": ")[1]

		##dollars_per_acre
		#self.dollars_per_acre = advanced_details_left[22].split(": ")[1]

		##dollars_per_square_foot
		#self.dollars_per_square_foot = advanced_details_left[23].split(": ")[1]

		##lot_description
		#self.lot_description = advanced_details_left[24].split(": ")[1]

		##lot_size
		#self.lot_size = advanced_details_left[25].split(": ")[1]

		##master_bedroom_dimensions
		#self.master_bedroom_dimensions = advanced_details_left[26].split(": ")[1]

		#node = doc.xpath("//div[@class='IDX-detailsAdvancedRight']").first

		#advanced_details_right = node.inner_html.split("<br>")

		##master_bedroom_level
		#self.master_bedroom_level = advanced_details_right[0].split(": ")[1]

		##fireplaces
		#self.fireplaces = advanced_details_right[1].split(": ")[1]

		##full_baths_level_1
		#self.full_baths_level_1 = advanced_details_right[2].split(": ")[1]

		##full_baths_level_2
		#self.full_baths_level_2 = advanced_details_right[3].split(": ")[1]

		##garage_spaces
		#self.garage_spaces = advanced_details_right[4].split(": ")[1]

		##living_areas
		#self.living_areas = advanced_details_right[5].split(": ")[1]

		##stories
		#self.stories = advanced_details_right[6].split(": ")[1]

		##parking_garage
		#self.parking_garage = advanced_details_right[7].split(": ")[1]

		##pool
		#self.pool = advanced_details_right[8].split(": ")[1]

		##possession
		#self.possession = advanced_details_right[9].split(": ")[1]

		##property_also_for_lease
		#self.property_also_for_lease = advanced_details_right[10].split(": ")[1]

		##proposed_financing
		#self.proposed_financing = advanced_details_right[11].split(": ")[1]

		##roofing
		#self.roofing = advanced_details_right[12].split(": ")[1]

		##school_district
		#self.school_district = advanced_details_right[13].split(": ")[1]

		##security_system
		#self.security_system = advanced_details_right[14].split(": ")[1]

		##single_family_type
		#self.single_family_type = advanced_details_right[15].split(": ")[1]

		##specialty_rooms
		#self.specialty_rooms = advanced_details_right[16].split(": ")[1]

		##square_foot_source
		#self.square_foot_source = advanced_details_right[17].split(": ")[1]

		##street_utilities
		#self.street_utilities = advanced_details_right[18].split(": ")[1]

		##study_dimensions
		#self.study_dimensions = advanced_details_right[19].split(": ")[1]

		##style_of_house
		#self.style_of_house = advanced_details_right[20].split(": ")[1]

		##covered_parking_spaces
		#self.covered_parking_spaces = advanced_details_right[21].split(": ")[1]

		##type_of_fence
		#self.type_of_fence = advanced_details_right[22].split(": ")[1]

		##unexempt_taxes
		#self.unexempt_taxes = advanced_details_right[23].split(": ")[1]

		##will_subdivide
		#self.will_subdivide = advanced_details_right[24].split(": ")[1]

		##year_built
		#self.year_built = advanced_details_right[25].split(": ")[1]

		return true
	end

	def import_pictures_from_mls
		if self.mls_number.blank?
			return false, "Error: The listing has no MLS number."
		end

		result = Net::HTTP.get(URI.parse("http://www.cedarealty.idxco.com/idx/9610/photoGallery.php?idxID=074&listingID=" + mls_number.to_s))

		doc = Nokogiri::HTML(result)

		node = doc.xpath("//div[@id='IDX-main']").first

		if node.inner_html.include?("  We were not able to find any photos for this property.")
			return false, "Error: No photos found."
		end

		doc.at_css("body").traverse do |node|
			if node.text?
				new_text = node.content.strip
				node.send(:native_content=, new_text)
			end
		end

		image_paths = Array.new

		doc.xpath("//img/@src").each do |node|
			if !node.content.index("MediaDisplay").nil?
				image_paths << node.content.gsub("lr", "hr").strip
			end
		end

		image_paths.uniq!

		for image_path in image_paths
			picture = Picture.create_from_remote(image_path)

			picture.attachable_type = "Listing"

			picture.attachable_id = self.id

			picture.save
		end
	end
end
