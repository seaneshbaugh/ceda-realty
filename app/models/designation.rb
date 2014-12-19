class Designation < ActiveRecord::Base
  include Publishable

  belongs_to :picture

  has_and_belongs_to_many :profiles

  has_many :users, through: :profiles

  validates_length_of :name, maximum: 255
  validates_presence_of :name
  validates_uniqueness_of :name

  validates_length_of :abbreviation, maximum: 255
  validates_presence_of :abbreviation
  validates_uniqueness_of :abbreviation

  validates_length_of :description, maximum: 65535

  validates_associated :picture

  default_value_for :name, ''

  default_value_for :abbreviation, ''

  default_value_for :description, ''
end
