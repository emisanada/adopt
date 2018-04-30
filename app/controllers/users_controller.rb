class UsersController < ApplicationController

  before_action :authenticate_user, only: [:edit, :update, :destroy], notice: 'You must sign in first!'
  before_action :check_current_user, only: [:edit, :update, :destroy]
  before_action :admin_access, only: [:index]

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
      Rails.logger.info "User #{@user.name} was created successfully, user_id: #{@user.id}"
      flash[:notice] = 'You signed up successfully!'
      redirect_to root_path
    else
      render 'new', status: 400
    end
  rescue => e
    Rails.logger.error "User creation failed! #{e.message} - #{e.bactrace.join("\n\t")}"
    flash[:error] = 'Ops! There was a problem on your signup!'
    redirect_to action: :new
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_update_params)
      Rails.logger.info "User #{@user.name} was updated successfully, user_id: #{@user.id}"
      flash[:notice] = 'Your changes were saved! Whoof!'
      redirect_to action: :show
    else
      render 'edit', status: 400
    end
  rescue => e
    Rails.logger.error "User update failed, user_id: #{params[:id]}! #{e.message} - #{e.bactrace.join("\n\t")}"
    flash[:error] = 'Ops! There was a problem saving your changes!'
    redirect_to action: :edit
  end

  def destroy
    User.find(params[:id]).destroy
    @user = User.all
    Rails.logger.info "User was deleted successfully, user_id: #{params[:id]}"
    redirect_to root_path
  rescue => e
    Rails.logger.error "User delete failed, user_id: #{params[:id]}! #{e.message} - #{e.bactrace.join("\n\t")}"
    flash[:error] = 'Ops! There was a problem saving your changes!'
    redirect_to action: :edit
  end

  private
    def user_params
      params.require(:user).permit(:name, :email, :location, :username, :password, :password_confirmation)
    end

    def user_update_params
      params.require(:user).permit(:name, :email, :location, :about, :admin)
    end

end
