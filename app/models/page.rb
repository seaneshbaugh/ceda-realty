class Page < ActiveRecord::Base
  include Ancestry
  include Publishable
  include Slugable

  validates_length_of :title, maximum: 255
  validates_presence_of :title
  validates_uniqueness_of :title, scope: :parent_id

  validates_uniqueness_of :slug, scope: :parent_id

  validates_length_of :full_path, maximum: 255
  validates_presence_of :full_path
  validates_uniqueness_of :full_path

  validates_length_of :body, maximum: 65535

  validates_length_of :style, maximum: 65535

  validates_length_of :script, maximum: 65535

  validates_length_of :meta_description, maximum: 65535

  validates_length_of :meta_keywords, maximum: 65535

  validates_inclusion_of :order, in: -2147483648..2147483647, message: 'is out of range'
  validates_numericality_of :order, only_integer: true
  validates_presence_of :order

  before_validation :generate_full_path

  default_value_for :title, ''

  default_value_for :full_path, ''

  default_value_for :body, ''

  default_value_for :style, ''

  default_value_for :script, ''

  default_value_for :meta_description, ''

  default_value_for :meta_keywords, ''

  default_value_for :show_in_menu, true

  default_value_for :order, 0

  protected

  def generate_full_path
    self.full_path = "#{ancestors.map { |ancestor| ancestor.slug }.join('/')}/#{slug}"
  end
end
