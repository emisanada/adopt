# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :current_user
  protect_from_forgery with: :exception
  skip_before_action :verify_authenticity_token

  def authenticate_user
    if !session[:user_id] && !api_call?
      return redirect_to(controller: 'sessions', action: 'login')
    end
    return @current_user = current_user if api_call?
    @current_user = User.find(session[:user_id])
  end

  def save_login_state
    return if !session[:user_id]
    redirect_to root_path
  end

  def current_user
    if api_call?
      @current_user = authenticate_with_http_basic do |username, password|
        authenticated_user?(username, password)
      end
    end

    @current_user ||= User.find(session[:user_id]) if session[:user_id]
    @current_user
  end

  def check_user
    if current_user.blank?
      flash[:error] = 'To do this action, please login first ;)'
      redirect_to login_path
    end
  end

  def check_current_user
    if current_user.blank? || (current_user.id.to_i != params[:id].to_i && !current_user.admin)
      flash[:error] = 'Restricted area! Paws off!'
      redirect_to root_path
    end
  end

  def authenticated_user?(username, password)
    User.find_by_username(username) && User.authenticate(username, password)
  end

  def admin_access
    if current_user.blank? || !current_user.admin
      flash[:error] = 'Restricted area! Paws off!'
      redirect_to root_path
    end
  end

  def api_call?
    request.content_type == Mime[:json]
  end
end
