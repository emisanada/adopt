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
    params[:pet][:adopted] = false
    @pet = Pet.new(pet_params)
    if @pet.save
      Rails.logger.info "Pet #{@pet.name} was created successfully, pet_id: #{@pet.id}"
      flash[:notice] = 'Pet listed for adoption successfully!'
      redirect_to action: :index
    else
      render 'new', status: 400
    end
  rescue => e
    Rails.logger.error "Pet creation failed! #{e.message} - #{e.bactrace.join("\n\t")}"
    flash[:error] = 'Ops! There was a problem on your pet form!'
    redirect_to action: :new
  end

  def edit
    @pet = Pet.find(params[:id])
  end

  def update
    @pet = Pet.find(params[:id])
    if @pet.update_attributes(pet_update_params)
      Rails.logger.info "Pet #{@pet.name} was updated successfully, pet_id: #{@pet.id}"
      flash[:notice] = 'Your changes were saved! Whoof!'
      redirect_to action: :show
    else
      render 'edit', status: 400
    end
  rescue => e
    Rails.logger.error "Pet update failed, pet_id: #{params[:id]}! #{e.message} - #{e.bactrace.join("\n\t")}"
    flash[:error] = 'Ops! There was a problem saving your changes!'
    redirect_to action: :edit
  end

  def destroy
    Pet.find(params[:id]).destroy
    @pet = User.all
    Rails.logger.info "Pet pet_id: #{params[:id]} deleted successfully!"
    flash[:notice] = 'Your changes were saved! Whoof!'
    redirect_to root_path
  rescue => e
    Rails.logger.error "Pet delete failed, pet_id: #{params[:id]}! #{e.message} - #{e.bactrace.join("\n\t")}"
    flash[:error] = 'Ops! There was a problem deleting that pet info!'
    redirect_to action: :edit
  end

  private
    def pet_params
      params.require(:pet).permit(:name, :species, :breed, :age, :location, :about, :adopted, :user_id)
    end

    def pet_update_params
      params.require(:pet).permit(:name, :species, :breed, :age, :location, :about, :adopted)
    end

    def check_owner
      pet = Pet.find(params[:id])
      if current_user.present? && (current_user.admin || current_user.id.to_i == pet.user_id.to_i)
        return true
      end
      flash[:error] = "Sorry! You don't have access to this page!"
      redirect_to root_path
    end
end
