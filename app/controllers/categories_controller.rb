class CategoriesController < ApplicationController
  layout "dashboard"
  before_action :authenticate_user!, :check_user_is_admin, only: [:create, :destroy]
  before_action :set_category, only: [:edit, :update, :destroy]
  
  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to request.referrer, flash: {success: "category added"}
    else
      redirect_to request.referrer, flash: {danger: "Something went wrong"}
    end
  end

  def destroy
    return unless current_user.admin
    return redirect_to request.referrer, flash: {success: "category deleted"} if @category.destroy
    flash[:warning] = "Cant be deleted"
  end
  
  def index
    @categories = Category.all
    @category = Category.new
  end

  private
  
  def category_params
    params.require(:category).permit(:category_name)
  end

  def set_category
    @category = Category.find(params[:id])
  end
end
