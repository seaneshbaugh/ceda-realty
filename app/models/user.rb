require 'email_validator'

class User < ActiveRecord::Base
  has_one :profile, dependent: :destroy

  devise :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable

  rolify

  validates_format_of     :username, with: /\A(?![_.])(?!.*[_.]{2})[a-zA-Z0-9._]+(?<![_.])\z/, allow_blank: true
  validates_length_of     :username, within: 3..255, allow_blank: true
  validates_presence_of   :username
  validates_uniqueness_of :username

  validates_presence_of   :email
  validates_uniqueness_of :email, case_sensitive: false, allow_blank: true
  validates               :email, email: { strict_mode: true }, allow_blank: true

  validates_confirmation_of :password
  validates_length_of       :password, within: 6..255, if: :password_required?, allow_blank: true
  validates_presence_of     :password, if: :password_required?

  # validates_inclusion_of :role, in: %w(read_only agent admin sysadmin)
  # validates_presence_of  :role

  validates_length_of   :first_name, maximum: 255
  validates_presence_of :first_name

  validates_length_of   :last_name, maximum: 255
  validates_presence_of :last_name

  default_value_for :username, ''

  default_value_for :email, ''

  default_value_for :encrypted_password, ''

  # default_value_for :role, 'read_only'

  default_value_for :first_name, ''

  default_value_for :last_name, ''

  default_value_for :sign_in_count, 0

  before_save :define_role

  def full_name
    "#{self.first_name} #{self.last_name}"
  end

  def short_name
    "#{self.first_name.first.upcase}. #{self.last_name}"
  end

  # def valid_roles
  #   if self.role == 'admin'
  #     ['admin', 'agent', 'read_only']
  #   elsif self.role == 'sysadmin'
  #     ['sysadmin', 'admin', 'agent', 'read_only']
  #   else
  #     []
  #   end
  # end

  protected

  def password_required?
    !self.persisted? || !self.password.blank? || !self.password_confirmation.blank?
  end

  def define_role
    add_role :user if roles.empty?
  end
end
