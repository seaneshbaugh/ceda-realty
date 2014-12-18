class BasePresenter
  delegate :auto_link, to: :@template
  delegate :link_to, to: :@template

  def initialize(object, template)
    @object = object

    @template = template
  end

  def method_missing(method, *args, &block)
    @object.send(method, *args, &block)
  rescue NoMethodError
    super
  end

  def created_at
    if @object.respond_to?(:created_at) && @object.created_at.present?
      @object.created_at.strftime(time_fomat)
    else
      'N/A'
    end
  end

  def updated_at
    if @object.respond_to?(:updated_at) && @object.updated_at.present?
      @object.updated_at.strftime(time_fomat)
    else
      'N/A'
    end
  end

  def form_title
    if @object.persisted?
      "Edit #{@object.class.base_class.to_s.titleize}"
    else
      "New #{@object.class.base_class.to_s.titleize}"
    end
  end

  private

  def time_fomat
    '%Y-%m-%d %I:%M:%S %p'
  end

  def date_format
    '%Y-%m-%d'
  end

  def format_user_input(text)
    auto_link(Sanitize.clean(text).gsub(/\r|\t/, '').strip, html: { target: '_blank' }).split("\n").reject { |line| line.empty? }.join('<br>').html_safe
  end
end
