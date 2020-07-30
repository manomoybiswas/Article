class HomeController < ApplicationController
  layout "dashboard", only: [:overview]
  def index
    @categories = Category.all
    @posts = Post.filtered_by_like(nil, params[:filters], current_user)
  end

  def overview
  end
end
