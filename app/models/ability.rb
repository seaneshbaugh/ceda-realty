class Ability
  def self.allowed(user, subject)
    return not_authorized_abilities(user, subject) if user.nil? || !user.kind_of?(User)

    case subject.class.name
    when 'Page' then page_instance_abilities(user, subject)
    when 'User' then user_instance_abilities(user, subject)
    when 'Class' then
      case subject.name
      when 'Page' then page_class_abilities(user)
      when 'User' then user_class_abilities(user)
      else []
      end
    else []
    end.concat(global_abilities(user))
  end

  def self.not_authorized_abilities(user, subject)
    []
  end

  def self.global_abilities(user)
    []
  end

  def self.page_class_abilities(user)
    case user.role
    when 'sysadmin' then [:create, :read, :update, :destroy]
    else []
    end
  end

  def self.user_class_abilities(user)
    case user.role
    when 'sysadmin' then [:create, :read, :update, :destroy]
    when 'admin' then [:create, :read, :update, :destroy]
    else []
    end
  end

  def self.page_instance_abilities(user, training_type)
    case user.role
    when 'admin' then [:read, :update, :destroy]
    when 'sysadmin' then [:read, :update, :destroy, :debug]
    else []
    end
  end

  def self.user_instance_abilities(user, other_user)
    if user == other_user
      [:read, :update, :destroy]
    else
      case user.role
      when 'sysadmin' then [:read, :update, :destroy, :debug]
      when 'admin' then
        if other_user.role != 'sysadmin' && other_user.role != 'admin'
          [:read, :update, :destroy]
        else
          [:read]
        end
      else []
      end
    end
  end

  class AccessDenied < StandardError
    attr_reader :action, :subject, :message
    attr_writer :default_message

    def initialize(action = nil, subject = nil)
      @action = action

      @subject = subject

      if @action && @subject
        @message = "You are not authorized to #{@action} this #{@subject}."
      end

      @default_message = 'You are not authorized to access this page.'
    end

    def to_s
      @message || @default_message
    end
  end
end
