class LoggerEvent < ActiveRecord::Base
	belongs_to :person

	EventTypeNotice			= "Notice"
	EventTypeSuccess		= "Success"
	EventTypeWarning		= "Warning"
	EventTypeError			= "Error"
	EventTypeFatalError		= "Fatal Error"
	EventTypeLogin			= "Login"
	EventTypeLogout			= "Logout"
	EventTypeObjectCreated	= "Object Created"
	EventTypeObjectModified	= "Object Modified"
	EventTypeObjectDeleted	= "Object Deleted"
	EventTypeOther			= "Other"
end
