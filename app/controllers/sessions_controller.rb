class SessionsController < ApplicationController
  before_action :set_user, only: [:create]
  
  def create
    return redirect_to root_path, flash: { warning: "Already logged in." } if current_user.present?
    begin
      user = @user && @user.authenticate(params[:login][:password])
    rescue BCrypt::Errors::InvalidHash
      render "new", flash: { danger: "Something went wrong" }
      return
    end
    
    if user
      if params[:remember_me]
        login_with_remember_me(@user)
      else
        login(@user)
      end
      redirect_to root_path, flash: { success: "login Successful" }
    else
      render "new", flash: { danger: "Invalid Credential" }
    end
  end  
  
  def destroy
    logout
    redirect_to root_path, flash: { success: "See you soon" }
  end

  def new
    return redirect_to root_path, flash: { warning: "Already logged in" } if current_user.present?
    @session = User.new
  end  

  private
  def set_user
    @user = User.find_by_email(params[:login][:email])
  end
end
