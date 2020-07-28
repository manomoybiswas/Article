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
      login(@user.id)
      if @user.admin
        redirect_to overview_path, flash: { success: "login Successful" }
      else
        redirect_to root_path, flash: { success: "login Successful" }
      end
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
  end  

  private
  def set_user
    @user = User.find_by_email(params[:login][:email])
  end
end
