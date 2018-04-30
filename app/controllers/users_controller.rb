class UsersController < ApplicationController

  before_action :authenticate_user, only: [:edit, :update, :destroy], notice: 'You must sign in first!'
  before_action :check_current_user, only: [:edit, :update, :destroy]

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = 'You signed up successfully!'
      redirect_to root_path
    else
      render 'new'
    end
  rescue => e
    flash[:error] = 'Ops! There was a problem on your signup!'
    redirect_to action: :new
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    user = User.find(params[:id]).update_attributes(user_update_params)
    flash[:notice] = 'Your changes were saved! Hurray!'
    redirect_to action: :show
  rescue => e
    flash[:error] = 'Ops! There was a problem saving your changes!'
    redirect_to action: :edit
  end

  def delete
  end

  private
    def user_params
      params.require(:user).permit(:name, :email, :location, :username, :password, :password_confirmation)
    end

    def user_update_params
      params.require(:user).permit(:name, :email, :location, :about, :admin)
    end

    def check_current_user
      if (current_user.present? && current_user.id.to_i === params[:id].to_i) || current_user.admin
        return true
      end
      flash[:error] = "Restricted area! Paws off!"
      redirect_to root_path
    end

end
