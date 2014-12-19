module Slugable
  extend ActiveSupport::Concern

  included do
    validates_exclusion_of :slug, in: %w(create designation designations destroy document documents edit index new office offices page pages picture pictures post posts show tag tags update user users), message: 'cannot be %{value}.'
    validates_length_of :slug, maximum: 255
    validates_presence_of :slug
    validates_uniqueness_of :slug

    before_validation :generate_slug

    default_value_for :slug, ''
  end

  def to_param
    slug
  end

  protected

  def generate_slug
    if name.blank?
      self.slug = id.to_s
    else
      self.slug = CGI.unescapeHTML(Sanitize.clean(name)).gsub(/'|"/, '').gsub(' & ', 'and').gsub('&', '').squeeze(' ').parameterize
    end
  end
end
