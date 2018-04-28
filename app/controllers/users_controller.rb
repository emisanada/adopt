class UsersController < ApplicationController

  def index
    @users = User.all
  end

  def find
  end

  def show
    @user = User.find(params[:id])
  end

  def new
  end

  def create
    user = User.create(user_params)
    users_errors = check_user_errors(user)
    user.save!
    flash[:notice] = 'You signed up successfully!'
    redirect_to root_path
  rescue => e
    flash[:error] = 'Ops! There was a problem on your signup!'
    if users_errors.present?
      flash[:error] = [flash[:error]] << users_errors
      flash[:error].flatten!
    end
    redirect_to action: :new
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    user = User.find(params[:id]).update_attributes(user_update_params)
    user.save!
    redirect_to root_path
  rescue => e
    flash[:error] = 'Ops! There was a problem saving your changes!'
    redirect_to root_path
  end

  def delete
  end

  private
    def user_params
      params.require(:user).permit(:name, :email, :location, :username, :password, :password_confirmation)
    end

    def user_update_params
      params.require(:user).permit(:name, :email, :location, :about)
    end

end
