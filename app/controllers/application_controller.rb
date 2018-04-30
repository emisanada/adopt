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
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def check_user
    if @current_user.blank?
      flash[:error] = "To do this action, please login first ;)"
      redirect_to login_path
    end
  end

  def check_current_user
    if (current_user.present? && current_user.id.to_i === params[:id].to_i) || current_user.admin
      return true
    end
    flash[:error] = "Restricted area! Paws off!"
    redirect_to root_path
  end

  def admin_access
    if current_user.blank? || !current_user.admin
      flash[:error] = "Restricted area! Paws off!"
      redirect_to root_path
    end
  end

end
