class HomeController < ApplicationController
  layout "dashboard", only: [:overview]
  before_action :authenticate_user!, only: [:overview]
  def index
    @categories = Category.all
    @posts = Post.filtered_by_like(nil, params[:filters], current_user)
  end

  def overview
    if current_user
      if current_user.admin
        @posts = Post.all.order("id desc").limit(3) 
        @comments = Comment.all.order("id desc").limit(3) 
      else
        @posts = Post.where(user_id: current_user.id).order("id desc").limit(3)
        @post = Post.where(user_id: current_user.id).select(:id)
        @comments = Comment.where(post_id: @post).order("id desc").limit(3)
      end
    end
  end
end
