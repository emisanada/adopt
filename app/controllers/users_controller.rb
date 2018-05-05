# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :authenticate_user, only: %i[edit update destroy], notice: 'You must sign in first!'
  before_action :check_current_user, only: %i[edit update destroy]
  before_action :admin_access, only: [:index]
  before_action :fetch_users, only: %i[index]
  before_action :fetch_current_user, only: %i[show edit update]
  before_action :new_user, only: %i[create]

  def new
    @user = User.new
  end

  def create
    if @user.save
      Rails.logger.info "User #{@user.name} was created! Id: #{@user.id}"
      flash[:notice] = 'You signed up successfully!'
      return redirect_to root_path
    end
    render 'new', status: 400
  rescue StandardError => e
    Rails.logger.error "User creation failed! #{e.message} - #{e.bactrace.join("\n\t")}"
    flash[:error] = 'Ops! There was a problem on your signup!'
    redirect_to action: :new
  end

  def update
    if @user.update_attributes(user_update_params)
      Rails.logger.info "User #{@user.name} was updated! Id: #{@user.id}"
      flash[:notice] = 'Your changes were saved! Whoof!'
      return redirect_to action: :show
    end
    render 'edit', status: 400
  rescue StandardError => e
    Rails.logger.error "User update failed, Id: #{params[:id]}! #{e.message} - #{e.bactrace.join("\n\t")}"
    flash[:error] = 'Ops! There was a problem saving your changes!'
    redirect_to action: :edit
  end

  def destroy
    User.find(params[:id]).destroy
    @user = User.all
    Rails.logger.info "User was deleted! Id: #{params[:id]}"
    redirect_to root_path
  rescue StandardError => e
    Rails.logger.error "User delete failed, Id: #{params[:id]}! #{e.message} - #{e.bactrace.join("\n\t")}"
    flash[:error] = 'Ops! There was a problem saving your changes!'
    redirect_to action: :edit
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :location, :username, :password,
                                 :password_confirmation)
  end

  def user_update_params
    params.require(:user).permit(:name, :email, :location, :about, :admin)
  end

  def fetch_users
    @users = User.all
  end

  def fetch_current_user
    @user = User.find(params[:id])
  end

  def new_user
    @user = User.new(user_params)
  end
end
