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
    if user.errors.any?
      users_errors = []
      user.errors.full_messages.each do |message|
        users_errors << message
      end
    end

    begin
      user.save!
      flash[:notice] = 'You signed up successfully'
      redirect_to root_path
    rescue => e
      flash[:error] = 'Ops! There was a problem on your signup!'
      if users_errors.present?
        flash[:error] = [flash[:error]] << users_errors
        flash[:error].flatten!
      end
      redirect_to action: :new
    end
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
