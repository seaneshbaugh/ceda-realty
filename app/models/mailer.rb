class Mailer < ActionMailer::Base
	def welcome(options)
		from "Welcome <welcome@cedarealty.com>"
		recipients options[:email_address]
		subject "Welcome!"
		content_type "text/html"

		body :person => options[:person]
	end

	def recovery(options)
		from "Account Recovery <recovery@cedarealty.com>"
		recipients options[:email_address]
		subject "Account Recovery"
		content_type "text/html"

		body :key => options[:key], :domain => options[:domain]
	end

	def contact(options)
		from "cedarealty.com Contact Form <contact@cedarealty.com>"
		recipients options[:email_address]
		subject options[:subject]
		content_type "text/html"

		body :body => options[:body]
	end
end
