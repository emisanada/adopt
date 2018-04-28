class SessionsController < ApplicationController

  before_action :authenticate_user, except: [:index, :login, :login_attempt, :logout]
  before_action :save_login_state, only: [:index, :login, :login_attempt]

  def login_attempt
    authorized_user = User.authenticate(params[:username],params[:login_password])
    if authorized_user
      session[:user_id] = authorized_user.id
      flash[:notice] = "Wow! Welcome again, you logged in as #{authorized_user.username}"
      redirect_to root_path
    else
      flash[:notice] = 'Invalid Username or Password'
      flash[:color]= 'invalid'
      render 'login'
    end
  end

  def logout
    session[:user_id] = nil
    redirect_to root_path
  end

end
