class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :add_abilities

  helper_method :abilities, :can?

  rescue_from Ability::AccessDenied do |exception|
    flash[:danger] = exception.to_s

    redirect_to root_url
  end

  def self.authorize_resource(*args)
    ControllerResource.add_before_action(self, :authorize_resource, *args)
  end

  protected

  def abilities
    @abilities ||= Six.new
  end

  def can?(object, action, subject)
    abilities.allowed?(object, action, subject)
  end

  def add_abilities
    abilities << Ability
  end
end
