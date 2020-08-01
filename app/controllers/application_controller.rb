class ApplicationController < ActionController::Base
  include SessionsHelper
  protect_from_forgery with: :exception
  helper_method :current_user
  
  def authenticate_user!
    redirect_to root_path, flash: {warning: "Please login with your credential" } unless current_user.present?
  end

  def check_user_is_admin
    redirect_to root_path,  flash: { warning: "You are not an admin." } unless current_user.admin
  end

  def current_user
    if cookies[:auth_token]
      @current_user ||= User.find_by_auth_token!(cookies[:auth_token])
    else
      @current_user = nil
    end
  end  
end
