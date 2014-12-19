module Publishable
  extend ActiveSupport::Concern

  included do
    scope :published, -> { where(published: true) }

    validates_inclusion_of :published, in: [true, false], message: 'must be true or false'
  end
end
