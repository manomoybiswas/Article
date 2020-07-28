module SessionsHelper
  def login(user_id)
    session[:user_id] = user_id
  end

  def logout
    session[:user_id] = nil
  end
end
