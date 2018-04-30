class UsersController < ApplicationController

  before_action :authenticate_user, only: [:edit, :update, :destroy], notice: 'You must sign in first!'
  before_action :check_current_user, only: [:edit, :update, :destroy]

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def create
    user = User.create(user_params)
    if user.errors.any?
      users_errors = []
      user.errors.full_messages.each do |message|
        users_errors << message
      end
    end
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
      params.require(:user).permit(:name, :email, :location, :about)
    end

    def check_current_user
      if current_user.blank? || !current_user.id.to_i === params[:id].to_i
        flash[:error] = "Restricted area"
        redirect_to root_path
      end
    end

end
