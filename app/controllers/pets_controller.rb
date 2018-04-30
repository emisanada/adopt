class PetsController < ApplicationController

  before_action :check_user, only: [:new, :create, :create, :update, :delete]
  before_action :check_owner, only: [:edit, :update, :destroy]

  def index
    @pets = Pet.all
  end

  def show
    @pet = Pet.find(params[:id])
  end

  def new
    @pet = Pet.new
  end

  def create
    params[:pet][:user_id] = current_user.id
    params[:pet][:status] = false
    @pet = Pet.new(pet_params)
    if @pet.save
      flash[:notice] = 'Pet listed for adoption successfully!'
      redirect_to action: :index
    else
      render 'new'
    end
  rescue => e
    flash[:error] = 'Ops! There was a problem on your pet form!'
    redirect_to action: :new
  end

  def edit
    @pet = Pet.find(params[:id])
  end

  def update
    pet = Pet.find(params[:id]).update_attributes(pet_update_params)
    flash[:notice] = 'Your changes were saved! Hurray!'
    redirect_to action: :show
  rescue => e
    flash[:error] = 'Ops! There was a problem saving your changes!'
    redirect_to action: :edit
  end

  def delete
  end

  private
    def pet_params
      params.require(:pet).permit(:name, :breed, :age, :location, :about, :status, :user_id)
    end

    def pet_update_params
      params.require(:pet).permit(:name, :breed, :age, :location, :about, :status)
    end

    def check_owner
      pet = Pet.find(params[:id])
      if current_user.blank? || !current_user.id.to_i === pet.user_id.to_i
        flash[:error] = "Sorry! You don't have access to this page!"
        redirect_to root_path
      end
    end
end
