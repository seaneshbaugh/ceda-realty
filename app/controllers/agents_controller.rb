require "will_paginate"

class AgentsController < ApplicationController
	def index
		#per_page = params[:per_page]

		#per_page ||= 25

		#params[:submit] = nil

		#if !params[:sort].nil? and !params[:order].nil?
			#sort_order = params[:sort].to_s + " " + params[:order].to_s
		#else
			#sort_order = "id ASC"
		#end

		#if !params[:search].blank?
			#search = "%" + params[:search] + "%"

			#@agents = Agent.paginate(:page => params[:page], :per_page => per_page, :order => sort_order, :conditions => ['id LIKE ?', search])
		#else
			#@agents = Agent.paginate(:page => params[:page], :per_page => per_page, :order => sort_order)
		#end

		@agents = Agent.find(:all)

		@agents.sort! {|x, y| x.person.last_name <=> y.person.last_name }

		@page_title = "Agents"
	end

	def show
		@agent = Agent.find_by_slug(params[:id])

		if @agent.nil?
			flash[:type] = "error"

			flash[:notice] = error_message_could_not_find("agent")

			redirect_to(agents_url) and return
		end

		result = Net::HTTP.get(URI.parse("http://sweb4.idxco.com/feeds/9610a22f20/advancedFeed.xml"))

		doc = Nokogiri::XML(result)

		@listings = Array.new

		doc.xpath("//listing").each do |node|
			agent_name = @agent.person.first_name + " " + @agent.person.last_name

			if node.xpath("agent-name").inner_text == agent_name or node.xpath("agent-name").inner_text == @agent.mls_name1 or node.xpath("agent-name").inner_text == @agent.mls_name2
				listing = Hash.new

				listing[:mls_number] = node.xpath("listing-id").inner_text
				listing[:street_address] = node.xpath("street-address").inner_text
				listing[:city] = node.xpath("city-name").inner_text
				listing[:zipcode] = node.xpath("zipcode").inner_text
				listing[:state] = node.xpath("state-code").inner_text
				listing[:price] = node.xpath("price").inner_text
				listing[:square_feet] = node.xpath("square-feet").inner_text
				listing[:bedrooms] = node.xpath("num-bedrooms").inner_text
				listing[:bathrooms] = node.xpath("num-full-bathrooms").inner_text
				listing[:half_bathrooms] = node.xpath("num-half-bathrooms").inner_text
				listing[:pictures] = node.xpath("pictures").inner_text
				listing[:link] = node.xpath("link").inner_text

				@listings << listing
			end
		end

		@listings.uniq!

		@page_title = "View Agent - " + @agent.person.first_name + " " + @agent.person.last_name
	end

	def contact
		@agent = Agent.find_by_slug(params[:id])

		if @agent.nil?
			flash[:type] = "error"

			flash[:notice] = error_message_could_not_find("agent")

			redirect_to(agents_url) and return
		end
	end

	def send_message
		@agent = Agent.find_by_slug(params[:id])

		if @agent.nil?
			flash[:type] = "error"

			flash[:notice] = error_message_could_not_find("agent")

			redirect_to(agents_url) and return
		end

		if params[:name].blank?
			flash[:type] = "error"

			flash[:notice] = "You must enter a name."

			redirect_to(:back) and return
		end

		if params[:email_address].blank? or params[:email_address].match(RFC2822::EmailAddress).nil?
			flash[:type] = "error"

			flash[:notice] = "You must enter a valid e-mail address."

			redirect_to(:back) and return
		end

		if params[:phone_number].blank? or params[:phone_number].match(/^([\+][0-9]{1,3}[ \.\-])?([\(]{1}[0-9]{2,6}[\)])?([0-9 \.\-\/]{3,20})((x|ext|extension)[ ]?[0-9]{1,4})?$/).nil?
			flash[:type] = "error"

			flash[:notice] = "You must enter a valid phone number."

			redirect_to(:back) and return
		end

		if params[:subject].blank?
			flash[:type] = "error"

			flash[:notice] = "Your message must include a subject."

			redirect_to(:back) and return
		end

		if params[:message].blank?
			flash[:type] = "error"

			flash[:notice] = "Your message must include a body."

			redirect_to(:back) and return
		end

		subject = "CEDA Realty Contact Form - Message from #{params[:email_address]}"

		body = "#{params[:email_address]} sent the following message through the cedarealty.com contact form.<br />Subject: #{params[:subject]}<br /><br />#{params[:message]}"

		Mailer.deliver_contact(:email_address => @agent.display_email_address, :subject => subject, :body => body)
		Mailer.deliver_contact(:email_address => "seaneshbaugh@gmail.com", :subject => subject, :body => body)

		flash[:type] = "success"

		flash[:notice] = "Thank you for your message! " + @agent.person.first_name + " will respond to your questions or comments as soon as possible."

		redirect_to(root_url) and return
	end
end
