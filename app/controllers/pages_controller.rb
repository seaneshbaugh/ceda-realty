class PagesController < ApplicationController
  def index
    @page = Page.where(is_home: true, published: true).first

    raise ActiveRecord::RecordNotFound unless @page.present?

    render :show
  end

  def show
    @page = Page.where(full_path: params[:full_path], is_home: false, published: true).first

    raise ActiveRecord::RecordNotFound unless @page.present?
  end
end
