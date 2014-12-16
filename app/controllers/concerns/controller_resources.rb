# https://github.com/ryanb/cancan/blob/master/lib/cancan/controller_resource.rb
class ControllerResource
  def self.add_before_action(controller_class, method, *args)
    options = args.extract_options!

    resource_name = args.first

    before_action_method = options.delete(:prepend) ? :prepend_before_action : :before_action

    controller_class.send(before_action_method, options.slice(:only, :except, :if, :unless)) do |controller|
      ControllerResource.new(controller, resource_name, options.except(:only, :except, :if, :unless)).send(method)
    end
  end

  def initialize(controller, *args)
    @controller = controller

    @params = controller.params

    @options = args.extract_options!

    @name = args.first
  end

  def authorize_resource
    if [:show, :edit, :update, :destroy].include? @params[:action]
      subject = resource_instance
    else
      subject = resource_class
    end

    case @params[:action]
    when 'new', 'create'  then action = :create
    when 'index', 'show'  then action = :read
    when 'edit', 'update' then action = :update
    when 'destroy'        then action = :destroy
    else                       action = @params[:action]
    end

    unless @controller.send(:can?, @controller.current_user, action, subject)
      raise Ability::AccessDenied.new
    end
  end

  protected

  def name
    @name || name_from_controller
  end

  def resource_instance
    @controller.instance_variable_get("@#{instance_name}")
  end

  def resource_class
    @options[:class] || name_from_controller.camelize.constantize
  end

  def name_from_controller
    @params[:controller].sub("Controller", "").underscore.split('/').last.singularize
  end

  def instance_name
    @options[:instance_name] || name
  end
end
