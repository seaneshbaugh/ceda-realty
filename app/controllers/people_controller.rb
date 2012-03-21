require "crypto"

class PeopleController < ApplicationController
	before_filter :ensure_logout, :only => [:help, :recover]

	def help

	end

	def recover
		person = Person.find_by_name(params[:name])

		if person
			#should probably make the domain be an environment variable
			Mailer.deliver_recovery(:key => Crypto.encrypt("#{person.id}:#{person.salt}"), :email_address => person.email_address, :domain => "cedarealty.com")

			flash[:type] = "information"

			flash[:notice] = "An e-mail has been sent to your address with information on how to recover your password."

			redirect_to(new_session_url) and return
		else
			flash[:type] = "error"

			flash[:notice] = "Your account could not be found."

			redirect_to(new_session_url) and return
		end
	end

	def send_message
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

		Mailer.deliver_contact(:email_address => "cedarealty@gmail.com", :subject => subject, :body => body)
		Mailer.deliver_contact(:email_address => "seaneshbaugh@gmail.com", :subject => subject, :body => body)

		flash[:type] = "success"

		flash[:notice] = "Thank you for your message! Our staff will respond to your questions or comments as soon as possible."

		redirect_to(root_url) and return
	end
end
