class UsersController < ApplicationController
  layout "dashboard", except: [:new]

  before_action :authenticate_user!, only: [:destroy, :edit, :index, :show, :update]
  before_action :check_user_is_admin, only: [:index]
  before_action :set_user, only: [:edit, :destroy, :show, :update]

  def create
    @user = User.new(user_params)
    if @user.save
      login(@user)
      redirect_to root_path, flash: { success: "You are Successfully Signed up and login Successful" }
    else
      render "new", flash: { danger: "Something went wrong" }
    end
  end
  
  def destroy
    return unless current_user.admin
    return redirect_to request.referrer, flash: {success: "User record deleted successfully."} if @user.destroy
    redirect_to request.referrer flash: {success: "Something went wrong. Please try again."}
  end

  def edit
    redirect_to root_path if !current_user.admin && @user.id != current_user.id
  end 

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def show
    return redirect_to root_path, flash: {warning: "Sign up required."} unless current_user.present?
  end

  def update
    if current_user.admin && @user != current_user
      if @user.update(user_params)
        redirect_to users_path, flash: { success: "Profile Updated" }
      else
        render "edit", flash: { danger: "Something went wrong"}
      end
    elsif @user.id == current_user.id
      @user.name = user_params[:name] if user_params[:name]
      @user.dob = user_params[:dob] if user_params[:dob]
      @user.mobile = user_params[:mobile] if user_params[:mobile]
      @user.avater = user_params[:avater] if user_params[:avater].present?
      @user.password = user_params[:password] if user_params[:password].present?
      @user.confirm_password = user_params[:confirm_password] if user_params[:confirm_password].present?
      redirect_to user_path(@user), flash: { success: "Profile Updated" } if @user.update(user_params)
    end
  end  

  private
  def user_params
    params.require(:user).permit(:name, :email, :mobile, :dob, :password, :confirm_password, :avater)
  end

  def set_user
    @user = User.find(params[:id])
  end

end
