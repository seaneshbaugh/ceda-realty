require "will_paginate"

class ListingsController < ApplicationController
	def index
		#@featured_listings = Listing.find(:all, :conditions => ["featured_listing = ?", 1])

		result = Net::HTTP.get(URI.parse("http://sweb4.idxco.com/feeds/9610a22f20/advancedFeed.xml"))

		doc = Nokogiri::XML(result)

		@featured_listings = Array.new

		doc.xpath("//listing").each do |node|
			if node.xpath("price").inner_text.to_i > 60000
				featured_listing = Hash.new

				featured_listing[:mls_number] = node.xpath("listing-id").inner_text
				featured_listing[:street_address] = node.xpath("street-address").inner_text
				featured_listing[:city] = node.xpath("city-name").inner_text
				featured_listing[:zipcode] = node.xpath("zipcode").inner_text
				featured_listing[:state] = node.xpath("state-code").inner_text
				featured_listing[:price] = node.xpath("price").inner_text
				featured_listing[:square_feet] = node.xpath("square-feet").inner_text
				featured_listing[:bedrooms] = node.xpath("num-bedrooms").inner_text
				featured_listing[:bathrooms] = node.xpath("num-full-bathrooms").inner_text
				featured_listing[:half_bathrooms] = node.xpath("num-half-bathrooms").inner_text
				featured_listing[:pictures] = node.xpath("pictures").inner_text
				featured_listing[:link] = node.xpath("link").inner_text
				featured_listing[:description] = node.xpath("description").inner_text

				@featured_listings << featured_listing
			end
		end

		@featured_listings.sort! { |x, y| y[:price].to_i <=> x[:price].to_i }

		per_page = params[:per_page]

		per_page ||= 25

		@featured_listings = @featured_listings.paginate(:page => params[:page], :per_page => per_page)

		@state_names = {
			"ALABAMA" => "AL",
			"ALASKA" => "AK",
			"ARIZONA" => "AZ",
			"ARKANSAS" => "AR",
			"CALIFORNIA" => "CA",
			"COLORADO" => "CO",
			"CONNECTICUT" => "CT",
			"DELAWARE" => "DE",
			"DISTRICT OF COLUMBIA" => "DC",
			"FLORIDA" => "FL",
			"GEORGIA" => "GA",
			"HAWAII" => "HI",
			"IDAHO" => "ID",
			"ILLINOIS" => "IL",
			"INDIANA" => "IN",
			"IOWA" => "IA",
			"KANSAS" => "KS",
			"KENTUCKY" => "KY",
			"LOUISIANA" => "LA",
			"MAINE" => "ME",
			"MARYLAND" => "MD",
			"MASSACHUSETTS" => "MA",
			"MICHIGAN" => "MI",
			"MINNESOTA" => "MN",
			"MISSISSIPPI" => "MS",
			"MISSOURI" => "MO",
			"MONTANA" => "MT",
			"NEBRASKA" => "NE",
			"NEVADA" => "NV",
			"NEW HAMPSHIRE" => "NH",
			"NEW JERSEY" => "NJ",
			"NEW MEXICO" => "NM",
			"NEW YORK" => "NY",
			"NORTH CAROLINA" => "NC",
			"NORTH DAKOTA" => "ND",
			"OHIO" => "OH",
			"OKLAHOMA" => "OK",
			"OREGON" => "OR",
			"PENNSYLVANIA" => "PA",
			"RHODE ISLAND" => "RI",
			"SOUTH CAROLINA" => "SC",
			"SOUTH DAKOTA" => "SD",
			"TENNESSEE" => "TN",
			"TEXAS" => "TX",
			"UTAH" => "UT",
			"VERMONT" => "VT",
			"VIRGINIA" => "VA",
			"WASHINGTON" => "WA",
			"WEST VIRGINIA" => "WV",
			"WISCONSIN" => "WI",
			"WYOMING" => "WY"
		}
	end

	def show
		if params[:id].nil?
			flash[:type] = "error"

			flash[:notice] = error_message_could_not_find("listing")

			redirect_to(root_url) and return
		end

		result = Net::HTTP.get(URI.parse("http://sweb4.idxco.com/feeds/9610a22f20/advancedFeed.xml"))

		doc = Nokogiri::XML(result)

		@listing = Hash.new

		doc.xpath("//listing").each do |node|
			if node.xpath("listing-id").inner_text == params[:id]
				@listing[:mls_number] = node.xpath("listing-id").inner_text
				@listing[:street_address] = node.xpath("street-address").inner_text
				@listing[:city] = node.xpath("city-name").inner_text
				@listing[:zipcode] = node.xpath("zipcode").inner_text
				@listing[:state] = node.xpath("state-code").inner_text
				@listing[:price] = node.xpath("price").inner_text
				@listing[:square_feet] = node.xpath("square-feet").inner_text
				@listing[:bedrooms] = node.xpath("num-bedrooms").inner_text
				@listing[:bathrooms] = node.xpath("num-full-bathrooms").inner_text
				@listing[:half_bathrooms] = node.xpath("num-half-bathrooms").inner_text
				@listing[:pictures] = node.xpath("pictures").inner_text
				@listing[:link] = node.xpath("link").inner_text
				@listing[:description] = node.xpath("description").inner_text
			end
		end

		@state_names = {
			"ALABAMA" => "AL",
			"ALASKA" => "AK",
			"ARIZONA" => "AZ",
			"ARKANSAS" => "AR",
			"CALIFORNIA" => "CA",
			"COLORADO" => "CO",
			"CONNECTICUT" => "CT",
			"DELAWARE" => "DE",
			"DISTRICT OF COLUMBIA" => "DC",
			"FLORIDA" => "FL",
			"GEORGIA" => "GA",
			"HAWAII" => "HI",
			"IDAHO" => "ID",
			"ILLINOIS" => "IL",
			"INDIANA" => "IN",
			"IOWA" => "IA",
			"KANSAS" => "KS",
			"KENTUCKY" => "KY",
			"LOUISIANA" => "LA",
			"MAINE" => "ME",
			"MARYLAND" => "MD",
			"MASSACHUSETTS" => "MA",
			"MICHIGAN" => "MI",
			"MINNESOTA" => "MN",
			"MISSISSIPPI" => "MS",
			"MISSOURI" => "MO",
			"MONTANA" => "MT",
			"NEBRASKA" => "NE",
			"NEVADA" => "NV",
			"NEW HAMPSHIRE" => "NH",
			"NEW JERSEY" => "NJ",
			"NEW MEXICO" => "NM",
			"NEW YORK" => "NY",
			"NORTH CAROLINA" => "NC",
			"NORTH DAKOTA" => "ND",
			"OHIO" => "OH",
			"OKLAHOMA" => "OK",
			"OREGON" => "OR",
			"PENNSYLVANIA" => "PA",
			"RHODE ISLAND" => "RI",
			"SOUTH CAROLINA" => "SC",
			"SOUTH DAKOTA" => "SD",
			"TENNESSEE" => "TN",
			"TEXAS" => "TX",
			"UTAH" => "UT",
			"VERMONT" => "VT",
			"VIRGINIA" => "VA",
			"WASHINGTON" => "WA",
			"WEST VIRGINIA" => "WV",
			"WISCONSIN" => "WI",
			"WYOMING" => "WY"
		}
	end

	def search_mls
		@uri = "http://www.cedarealty.idxco.com/idx/9610/results.php?lp=" + params[:lp] + "&hp=" + params[:hp] + "&sqFt=" + params[:sqFt] + "&bd=" + params[:bd] + "&ba=" + params[:ba]

		if !params[:city].blank? and !params[:city].empty?
			for city in params[:city]
				@uri += "&city[]=" + city
			end
		else
			@uri += "&city[]="
		end

		@uri += "&searchSubmit=Begin+Search"
	end

	def advanced_search
		#@uri = "http://www.cedarealty.idxco.com/idx/9610/results.php?stp=advanced&idxID=074&showField=cityField&srt=DESC&start=0&per=10"
	end
end
