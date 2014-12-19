class PostsController < ApplicationController
  def index
    respond_to do |format|
      format.html do
        if params[:tag].present?
          @posts = Post.tagged_with(params[:tag]).published.includes(:user).page(params[:page]).per(25).reverse_chronological_order
        else
          @posts = Post.published.includes(:user).page(params[:page]).per(25).reverse_chronological_order
        end
      end

      format.rss do
        @posts = Post.published.includes(:user).reverse_chronological_order
      end
    end
  end

  def show
    @post = Post.published.where(slug: params[:id]).first

    fail ActiveRecord::RecordNotFound if @post.nil?
  end
end
