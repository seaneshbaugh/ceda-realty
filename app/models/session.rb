class Session < ActiveRecord::Base
	attr_accessor :name, :password, :match

	belongs_to :person

	before_validation :authenticate_person

	validates_presence_of :match, :message => "The name and password combination you provided could not be found.", :unless => :session_has_been_associated?

	before_save :associate_session_to_person

	before_save :remove_duplicates

	#after_create { |session| LoggerEvent.new(:person => session.person, :event_type => LoggerEvent::EventTypeLogin, :description => "#{session.person.name} has logged in from #{session.ip_address}.", :visible => true).save }

	#after_destroy { |session| LoggerEvent.new(:person => session.person, :event_type => LoggerEvent::EventTypeLogout, :description => "#{session.person.name} has logged out.", :visible => true).save }

	private

	def authenticate_person
		self.match = Person.find_by_name_and_password(self.name, self.password) unless session_has_been_associated?
	end

	def associate_session_to_person
		self.person_id ||= self.match.id
	end

	def session_has_been_associated?
		self.person_id
	end

	def remove_duplicates
		duplicates = Session.find_all_by_person_id_and_ip_address(self.person_id, self.ip_address)

		if !duplicates.nil?
			duplicates.delete(self)
		end

		for duplicate in duplicates
			Session.destroy(duplicate)
		end
	end
end
