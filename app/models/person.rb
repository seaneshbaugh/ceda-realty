require "digest/sha2"
require "RFC2822"

class Person < ActiveRecord::Base
	attr_reader :password

	has_one :agent, :dependent => :destroy

	has_many :agent_resources

	has_many :blogs

	has_many :logger_events

	has_many :posts

	has_many :sessions, :dependent => :destroy

	validates_uniqueness_of :name, :message => "is already in use by another person"

	validates_uniqueness_of :email_address, :message => "is already in use by another person"

	validates_format_of :name, :with => /^([a-z0-9_]{4,16})$/i, :message => "must be 4 to 16 letters, numbers or underscores and have no spaces"

	validates_format_of :password, :with => /^([\x20-\x7E]){6,32}$/, :message => "must be 6 to 32 characters", :unless => :password_is_not_being_updated?

	validates_format_of :email_address, :with => RFC2822::EmailAddress, :message => "must be a valid e-mail address"

	validates_format_of :phone_number, :with => /^\d{3}-\d{3}-\d{4}$/, :message => "must be a valid phone number"

	validates_confirmation_of :password, :email_address

	validates_presence_of :name, :email_address, :first_name, :last_name

	before_save :scrub_name, :update_agent_slug

	after_save :flush_passwords

	PrivilegeLevelGuest		= 0
	PrivilegeLevelUser		= 1
	PrivilegeLevelAgent		= 2
	PrivilegeLevelModerator	= 3
	PrivilegeLevelAdmin		= 4
	PrivilegeLevelSysOp		= 5

	def self.find_by_name_and_password(name, password)
		person = self.find_by_name(name)

		if person and person.encrypted_password == Digest::SHA256.hexdigest(password + person.salt)
			return person
		end
	end

	def password=(password)
		@password = password

		unless password_is_not_being_updated?
			self.salt = [Array.new(9){rand(256).chr}.join].pack('m').chomp

			self.encrypted_password = Digest::SHA256.hexdigest(password + self.salt)
		end
	end

	def update_ip_log(remote_ip)
		#check to see if they've been here before
		if !self.ip_addresses.blank?
			#get list of ips they've used (split on ;)
			ips = self.ip_addresses.split(";")

			ip_exists = false

			#go through each ip address they've used and see if it
			#matches their current one using request.remote_ip
			for ip in ips
				if remote_ip == ip
					ip_exists = true

					break
				end
			end

			#if it wasn't found then add it to the end of the list
			if !ip_exists
				ips << remote_ip
			end

			#truncate the ips list to be only the last 15
			ips = ips.last(15)

			#reset the list to be empty
			self.ip_addresses = ""

			#go through each ip address they've used
			for ip in ips
				self.ip_addresses = self.ip_addresses + ip + ";"
			end
		#if they haven't been here before
		else
			self.ip_addresses = remote_ip + ";"
		end
	end

	def generate_cookie_code
		self.cookie_code = ""

		chars = ("0".."9").to_a + ("a".."z").to_a + ("A".."Z").to_a

		128.times do
			self.cookie_code << chars[rand(chars.length - 1)]
		end

		return self.cookie_code
	end

	private

	def scrub_name
		self.name.downcase!
	end

	def update_agent_slug
		if !self.agent.nil?
			if self.first_name.blank? or self.last_name.blank?
				self.agent.slug = self.id
			else
				self.agent.slug = "#{self.first_name.downcase.gsub(/[^[:alnum:]]/,'-')}-#{self.last_name.downcase.gsub(/[^[:alnum:]]/,'-')}".gsub(/-{2,}/,'-')
			end

			self.agent.save
		end
	end

	def flush_passwords
		@password = @password_confirmation = nil
	end

	def password_is_not_being_updated?
		self.id and self.password.blank?
	end
end
