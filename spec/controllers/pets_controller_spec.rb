require 'spec_helper'
require 'rails_helper'

describe PetsController do

  before do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    allow_any_instance_of(ApplicationController).to receive(:check_user).and_return(true)
    allow_any_instance_of(PetsController).to receive(:check_owner).and_return(true)
  end

  let(:user) { FactoryBot.build :user, id: 1 }
  let(:pet) { FactoryBot.build :pet, id: 1 }
  let(:pet_params) do
    {
      pet: {
        name: 'Pikachu',
        species: 'Pokemon',
        breed: 'Mouse Pokemon',
        age: '3 years',
        location: 'Pallet Town',
        about: 'Eletric type pokemon ready to find its trainer!',
        adopted: false,
        user_id: 1
      }
    }
  end

  describe '.create' do
    context 'when successfully create pet' do
      before do
        post :create, params: pet_params
      end
      it { expect(response.status).to eq 302 }
      it { expect(flash[:error]).not_to be_present }
      it { expect(flash[:notice]).to be_present }
      it { expect(flash[:notice]).to eq 'Pet listed for adoption!' }
      it { expect(response).to redirect_to action: :index }
    end

    context 'when name is blank' do
      before do
        pet_params[:pet][:name] = ''
        post :create, params: pet_params
      end
      it { expect(response.status).to eq 400 }
      it { expect(flash[:notice]).not_to be_present }
      it { expect(response).to render_template :new }
    end

    context 'when name is too short' do
      before do
        pet_params[:pet][:name] = 'a'
        post :create, params: pet_params
      end
      it { expect(response.status).to eq 400 }
      it { expect(flash[:notice]).not_to be_present }
      it { expect(response).to render_template :new }
    end

    context 'when species is blank' do
      before do
        pet_params[:pet][:species] = ''
        post :create, params: pet_params
      end
      it { expect(response.status).to eq 400 }
      it { expect(flash[:notice]).not_to be_present }
      it { expect(response).to render_template :new }
    end

    context 'when breed is blank' do
      before do
        pet_params[:pet][:breed] = ''
        post :create, params: pet_params
      end
      it { expect(response.status).to eq 400 }
      it { expect(flash[:notice]).not_to be_present }
      it { expect(response).to render_template :new }
    end

    context 'when location is blank' do
      before do
        pet_params[:pet][:location] = ''
        post :create, params: pet_params
      end
      it { expect(response.status).to eq 400 }
      it { expect(flash[:notice]).not_to be_present }
      it { expect(response).to render_template :new }
    end

    context 'when about is blank' do
      before do
        pet_params[:pet][:about] = ''
        post :create, params: pet_params
      end
      it { expect(response.status).to eq 400 }
      it { expect(flash[:notice]).not_to be_present }
      it { expect(response).to render_template :new }
    end
  end

  describe '.update' do
    before do
      allow(Pet).to receive(:find).and_return(pet)
    end

    context 'when successfully update pet info' do
      before do
        patch :update, params: { id: pet.id, pet: pet_params[:pet] }
      end
      it { expect(response.status).to eq 302 }
      it { expect(flash[:error]).not_to be_present }
      it { expect(flash[:notice]).to be_present }
      it { expect(flash[:notice]).to eq 'Your changes were saved! Whoof!' }
      it { expect(response).to redirect_to action: :show }
    end

    context 'when name is nil' do
      before do
        pet_params[:pet][:name] = ''
        patch :update, params: { id: pet.id, pet: pet_params[:pet] }
      end
      it { expect(response.status).to eq 400 }
      it { expect(flash[:notice]).not_to be_present }
      it { expect(response).to render_template :edit }
    end

    context 'when breed is nil' do
      before do
        pet_params[:pet][:breed] = ''
        patch :update, params: { id: pet.id, pet: pet_params[:pet] }
      end
      it { expect(response.status).to eq 400 }
      it { expect(flash[:notice]).not_to be_present }
      it { expect(response).to render_template :edit }
    end

    context 'when location is nil' do
      before do
        pet_params[:pet][:location] = ''
        patch :update, params: { id: pet.id, pet: pet_params[:pet] }
      end
      it { expect(response.status).to eq 400 }
      it { expect(flash[:notice]).not_to be_present }
      it { expect(response).to render_template :edit }
    end

    context 'when logged out' do
      before do
        allow_any_instance_of(ApplicationController).to receive(:check_user).and_call_original
        patch :update, params: { id: pet.id, pet: pet_params[:pet] }
      end
      it { expect(response.status).to eq 302 }
      it { expect(flash[:notice]).not_to be_present }
      it { expect(flash[:error]).to be_present }
      it { expect(flash[:error]).to eq 'To do this action, please login first ;)' }
      it { expect(response).to redirect_to login_path }
    end

    context 'when user is not pet owner or admin' do
      before do
        user.id = 2
        allow_any_instance_of(PetsController).to receive(:check_owner).and_call_original
        patch :update, params: { id: user.id, pet: pet_params[:pet] }
      end
      it { expect(response.status).to eq 302 }
      it { expect(flash[:notice]).not_to be_present }
      it { expect(flash[:error]).to be_present }
      it { expect(flash[:error]).to eq "Sorry! You don't have access to this page!" }
      it { expect(response).to redirect_to root_path }
    end
  end

  describe '.destroy' do
    before do
      allow(Pet).to receive(:find).and_return(pet)
    end

    context 'when successfully delete pet info' do
      before do
        delete :destroy, params: { id: pet.id, pet: pet_params[:pet] }
      end
      it { expect(response.status).to eq 302 }
      it { expect(flash[:error]).not_to be_present }
      it { expect(flash[:notice]).to be_present }
      it { expect(flash[:notice]).to eq 'Your changes were saved! Whoof!' }
      it { expect(response).to redirect_to root_path }
    end

    context 'when logged out' do
      before do
        allow_any_instance_of(ApplicationController).to receive(:check_user).and_call_original
        delete :destroy, params: { id: pet.id, pet: pet_params[:pet] }
      end
      it { expect(response.status).to eq 302 }
      it { expect(flash[:notice]).not_to be_present }
      it { expect(flash[:error]).to be_present }
      it { expect(flash[:error]).to eq 'To do this action, please login first ;)' }
      it { expect(response).to redirect_to login_path }
    end

    context 'when user is not pet owner or admin' do
      before do
        user.id = 2
        allow_any_instance_of(PetsController).to receive(:check_owner).and_call_original
        delete :destroy, params: { id: user.id, pet: pet_params[:pet] }
      end
      it { expect(response.status).to eq 302 }
      it { expect(flash[:notice]).not_to be_present }
      it { expect(flash[:error]).to be_present }
      it { expect(flash[:error]).to eq "Sorry! You don't have access to this page!" }
      it { expect(response).to redirect_to root_path }
    end
  end
end
