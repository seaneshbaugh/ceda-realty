class Post < ActiveRecord::Base
  include Publishable
  include Slugable

  scope :reverse_chronological_order, -> { order('posts.created_at DESC') }

  belongs_to :user

  validates_presence_of :user_id

  validates_length_of :title, maximum: 255
  validates_presence_of :title
  validates_uniqueness_of :title

  validates_length_of :body, maximum: 65535

  validates_length_of :style, maximum: 65535

  validates_length_of :script, maximum: 65535

  validates_length_of :meta_description, maximum: 65535

  validates_length_of :meta_keywords, maximum: 65535

  validates_associated :user

  acts_as_taggable

  default_value_for :title, ''

  default_value_for :body, ''

  default_value_for :style, ''

  default_value_for :script, ''

  default_value_for :meta_description, ''

  default_value_for :meta_keywords, ''

  default_value_for :published, true

  def more
    if body.include?('<!--more-->')
      body[0..body.index('<!--more-->') - 1]
    else
      body
    end
  end

  def truncated?
    body.length > more.length
  end

  def first_image
    images = Nokogiri::HTML(body).xpath('//img')

    if images.length > 0
      images.first['src']
    else
      nil
    end
  end
end
