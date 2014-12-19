class Office < ActiveRecord::Base
  include Publishable
  include Slugable

  belongs_to :picture

  belongs_to :manager, class_name: 'User'

  validates_length_of :name, maximum: 255
  validates_presence_of :name
  validates_uniqueness_of :name

  validates_length_of :street_address_1, maximum: 255

  validates_length_of :street_address_2, maximum: 255

  validates_length_of :city, maximum: 255

  validates_length_of :state, maximum: 255

  validates_length_of :zipcode, maximum: 255

  validates_length_of :phone_number, maximum: 255

  validates_length_of :fax_number, maximum: 255

  validates_length_of :description_body, maximum: 65535

  validates_length_of :description_style, maximum: 65535

  validates_length_of :description_script, maximum: 65535

  validates_length_of :google_maps_uri, maximum: 4095
  validates :google_maps_uri, url: { allow_blank: true }
end
