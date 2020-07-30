class PostsController < ApplicationController
  layout "dashboard", only: [:edit, :index, :new]
  before_action :authenticate_user!, only: [:create, :destroy, :edit, :like, :new, :update]
  before_action :set_post, only: [:edit, :destroy, :like, :show, :update]

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      redirect_to posts_path, flash: {success: 'Article published successfully' }
    else
      render 'new', flash: {danger: 'something went wrong'}
    end
  end

  def destroy
    return unless current_user.admin || @post.user_id == current_user.id

    if @post.destroy
      redirect_to posts_path, flash: { danger: 'Article removed from our site'}
    else
      redirect_to request.referrer
    end
  end

  def edit 
    return unless current_user && (current_user.admin || @post.user_id == current_user.id)
  end

  def filtered_posts
    @categories = Category.all
    @posts = Post.filtered_by_like(params[:id], params[:filters], current_user)
  end

  def index
    @posts = if current_user && current_user.admin
      Post.all.includes(:category, :comments, :user )
    else
      @posts = Post.find_post(current_user)
    end
  end

  def like
    if !current_user.liked? @post
      @post.liked_by current_user
      Like.new(post_id: @post.id, user_id: current_user.id).save
    elsif current_user.liked? @post
      @post.unliked_by current_user
      Like.where(post_id: @post.id, user_id: current_user.id).destroy_all
    end
  end
  
  def new
    @post = Post.new
  end

  def search
    @posts = Post.search(params[:query]).order("updated_at DESC")
  end

  def show
    
    @comment = Comment.new
    @comment.post_id = @post.id
    @comments = @post.comments.order("id DESC")
    render layout: "dashboard" if current_user && (current_user.admin || @post.user_id == current_user.id)
  end

  def update
    return unless current_user.admin || @post.user_id == current_user.id

    if @post.update(post_params)
      redirect_to posts_path, flash:{success: 'updated'}
    else
      render 'edit'
    end
  end

  private

  def post_params
    params.require(:post).permit(:category_id, :post_name, :description, :image)
  end

  def set_post
    @post = Post.find(params[:id])
  end

end
