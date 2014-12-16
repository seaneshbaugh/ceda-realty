class Page < ActiveRecord::Base
  validates_length_of     :title, maximum: 255
  validates_presence_of   :title
  validates_uniqueness_of :title

  validates_length_of     :slug, maximum: 255
  validates_presence_of   :slug
  validates_uniqueness_of :slug

  validates_length_of     :full_path, maximum: 255
  validates_presence_of   :full_path
  validates_uniqueness_of :full_path

  validates_length_of :body, maximum: 65535

  validates_length_of :style, maximum: 65535

  validates_length_of :meta_description, maximum: 65535

  validates_length_of :meta_keywords, maximum: 65535

  validates_inclusion_of    :order, in: -2147483648..2147483647, message: 'is out of range'
  validates_numericality_of :order, only_integer: true
  validates_presence_of     :order

  before_validation :generate_slug

  default_value_for :title, ''

  default_value_for :slug, ''

  default_value_for :full_path, ''

  default_value_for :body, ''

  default_value_for :style, ''

  default_value_for :meta_description, ''

  default_value_for :meta_keywords, ''

  default_value_for :order, 0

  def to_param
    self.slug
  end

  protected

  def generate_slug
    if self.title.blank?
      self.slug = self.id.to_s
    else
      self.slug = self.title.parameterize
    end
  end
end
