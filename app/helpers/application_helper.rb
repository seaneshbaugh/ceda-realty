module ApplicationHelper
  def page_meta_description(meta_description)
    if meta_description.present?
      meta_description.strip
    else
      'CEDA Realty, reinventing the real estate experience!'
    end
  end

  def page_title(title)
    if title.present?
      title.strip
    else
      'CEDA Realty'
    end
  end

  def present(object, klass = nil)
    klass ||= "#{object.class}Presenter".constantize

    presenter = klass.new(object, self)

    yield presenter if block_given?

    presenter
  end
end
