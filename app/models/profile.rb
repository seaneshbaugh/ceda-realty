class Profile < ActiveRecord::Base
  include Publishable
  include Slugable

  belongs_to :user

  belongs_to :picture

  belongs_to :office

  has_many :mls_names

  has_and_belongs_to_many :designations

  validates_presence_of :user_id

  validates_length_of :display_name, maximum: 255

  validates_length_of :title, maximum: 255

  validates_length_of :display_email_address, maximum: 255

  validates_length_of :display_phone_number, maximum: 255

  validates_length_of :website_uri, maximum: 255
  validates :website_uri, url: { allow_blank: true }

  validates_length_of :facebook_uri, maximum: 255
  validates :facebook_uri, url: { allow_blank: true }

  validates_length_of :twitter_username, maximum: 255

  validates_length_of :linked_in_uri, maximum: 255
  validates :linked_in_uri, url: { allow_blank: true }

  validates_length_of :active_rain_uri, maximum: 255
  validates :active_rain_uri, url: { allow_blank: true }

  validates_length_of :youtube_uri, maximum: 255
  validates :youtube_uri, url: { allow_blank: true }

  validates_length_of :instagram_uri, maximum: 255
  validates :instagram_uri, url: { allow_blank: true }

  validates_length_of :bio_body, maximum: 65535

  validates_length_of :bio_style, maximum: 65535

  validates_length_of :bio_script, maximum: 65535

  validates_length_of :license_number, maximum: 255

  validates_inclusion_of :years_of_experience, allow_blank: true, in: 0..100, message: 'is out of range'
  validates_numericality_of :years_of_experience, allow_blank: true, only_integer: true

  validates_date :joined_at, allow_blank: true, on_or_after: -> { Date(2011, 3, 28) }, on_or_after_message: 'must be after CEDA Realty was founded'
end
