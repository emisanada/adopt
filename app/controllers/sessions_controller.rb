# frozen_string_literal: true

class SessionsController < ApplicationController
  before_action :authenticate_user, except: %i[index login logout]
  before_action :save_login_state, only: %i[index login]

  def login
    authorized_user = User.authenticate(params[:username], params[:login_password])
    if authorized_user
      session[:user_id] = authorized_user.id
      flash[:notice] = "Wow! Welcome again, you logged in as #{authorized_user.username}"
      redirect_to root_path
    else
      flash[:error] = 'Invalid Username or Password'
      render login_path
    end
  end

  def logout
    session[:user_id] = nil
    redirect_to root_path
  end
end
