class PetsController < ApplicationController

  before_action :check_user, only: [:new, :create, :create, :update, :delete]

  def index
    @pets = Pet.all
  end

  def find
  end

  def show
  end

  def new
  end

  def create
    params[:pet][:user_id] = @current_user.id
    params[:pet][:status] = false
    pet = Pet.create(pet_params)
    if pet.errors.any?
      pets_errors = []
      pet.errors.full_messages.each do |message|
        pets_errors << message
      end
    end
    pet.save!
    flash[:notice] = 'Pet listed for adoption successfully!'
    redirect_to action: :index
  rescue => e
    flash[:error] = 'Ops! There was a problem on your pet form!'
    if pets_errors.present?
      flash[:error] = [flash[:error]] << pets_errors
      flash[:error].flatten!
    end
    redirect_to action: :new
  end

  def edit
  end

  def update
  end

  def delete
  end

  private
    def pet_params
      params.require(:pet).permit(:name, :breed, :age, :location, :about, :status, :user_id)
    end
end
