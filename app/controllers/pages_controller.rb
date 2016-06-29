class PagesController < ApplicationController
  def index
  end

  def show
    @page = Page.where(full_path: params[:full_path], published: true).first

    raise ActiveRecord::RecordNotFound unless @page.present?
  end
end
