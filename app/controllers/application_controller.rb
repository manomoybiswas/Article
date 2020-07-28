class ApplicationController < ActionController::Base
  include SessionsHelper
  helper_method :current_user

  def current_user
    if session[:user_id]
      @current_user ||= User.find(session[:user_id])
    else
      @current_user = nil
    end
  end

  def authenticate_user!
    redirect_to root_path, flash: {warning: "Please login with your credential" } unless current_user.present?
  end
end
