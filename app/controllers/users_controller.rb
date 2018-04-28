class UsersController < ApplicationController

  def index
    @users = User.all
  end

  def find
  end

  def show
  end

  def new
  end

  def create
    user = User.new(user_params)
    user.save
    if user.save!
      flash[:notice] = 'You signed up successfully'
    else
      flash[:error]= 'Ops! There was a problem on your signup!'
    end
    redirect_to root_path
  rescue => e
    Rails.logger.error "-------------> #{e.message}"
    Rails.logger.error "-------------> #{e.backtrace.join("\n\t")}"
    flash[:error]= 'invalid'
    redirect_to root_path
  end

  def edit
  end

  def update
  end

  def delete
  end

  private
    def user_params
      params.require(:user).permit(:name, :email, :location, :username, :password, :password_confirmation)
    end

end
