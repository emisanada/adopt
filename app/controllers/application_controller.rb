class ApplicationController < ActionController::Base

  before_action :current_user

  def authenticate_user
    if session[:user_id]
      @current_user = User.find(session[:user_id])
      return true
    end
    redirect_to(controller: 'sessions', action: 'login')
    false
  end

  def save_login_state
    if session[:user_id]
      redirect_to root_path
      return false
    end
    true
  end

  def current_user
    @current_user = User.find(session[:user_id]) if session[:user_id]
  end

end
