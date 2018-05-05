# frozen_string_literal: true

class PetsController < ApplicationController
  before_action :check_user, only: %i[new create update destroy]
  before_action :check_owner, only: %i[edit update destroy]
  before_action :fetch_pets, only: %i[index]
  before_action :fetch_current_pet, only: %i[show edit update]
  before_action :new_pet, only: %i[create]

  def new
    @pet = Pet.new
  end

  def create
    if @pet.save
      Rails.logger.info "Pet #{@pet.name} was created! Id: #{@pet.id}"
      flash[:notice] = 'Pet listed for adoption!'
      return redirect_to action: :index
    end
    render 'new', status: 400
  rescue StandardError => e
    Rails.logger.error "Pet creation failed! #{e.message} - #{e.backtrace.join("\n\t")}"
    flash[:error] = 'Ops! There was a problem on your pet form!'
    redirect_to action: :new
  end

  def update
    if @pet.update_attributes(pet_update_params)
      Rails.logger.info "Pet #{@pet.name} was updated! Id: #{@pet.id}"
      flash[:notice] = 'Your changes were saved! Whoof!'
      return redirect_to action: :show
    end
    render 'edit', status: 400
  rescue StandardError => e
    Rails.logger.error "Pet update failed, Id: #{params[:id]}! #{e.message} - #{e.backtrace.join("\n\t")}"
    flash[:error] = 'Ops! There was a problem saving your changes!'
    redirect_to action: :edit
  end

  def destroy
    Pet.find(params[:id]).destroy
    @pet = Pet.all
    Rails.logger.info "Pet Id: #{params[:id]} deleted!"
    flash[:notice] = 'Your changes were saved! Whoof!'
    redirect_to root_path
  rescue StandardError => e
    Rails.logger.error "Pet delete failed, Id: #{params[:id]}! #{e.message} - #{e.backtrace.join("\n\t")}"
    flash[:error] = 'Ops! There was a problem deleting that pet info!'
    redirect_to action: :edit
  end

  private

  def pet_params
    params.require(:pet).permit(:name, :species, :breed, :age, :location,
                                :about, :adopted, :picture, :user_id)
  end

  def pet_update_params
    params.require(:pet).permit(:name, :species, :breed, :age, :location,
                                :about, :picture, :adopted)
  end

  def check_owner
    pet = Pet.find(params[:id])
    if current_user.present? && (current_user.admin || current_user.id.to_i == pet.user_id.to_i)
      return true
    end
    flash[:error] = "Sorry! You don't have access to this page!"
    redirect_to root_path
  end

  def fetch_pets
    @pets = Pet.all
  end

  def fetch_current_pet
    @pet = Pet.find(params[:id])
  end

  def new_pet
    params[:pet][:user_id] = current_user.id
    params[:pet][:adopted] = false
    @pet = Pet.new(pet_params)
  end
end
