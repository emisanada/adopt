require 'spec_helper'
require 'rails_helper'

describe PetsController do

  describe '.create' do
    before do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      allow_any_instance_of(ApplicationController).to receive(:check_user).and_return(true)
      allow_any_instance_of(PetsController).to receive(:check_owner).and_return(true)
    end
    let(:user) { FactoryBot.build :user, id: 1 }
    let(:pet_params) do
      {
        pet: {
          name: 'Pikachu',
          breed: 'Mouse Pokemon',
          age: '3 years',
          location: 'Pallet Town',
          status: false,
          about: 'Eletric type pokemon ready to find its trainer!',
          user_id: 1
        }
      }
    end

    context 'when success' do
      before do
        post :create, params: pet_params
      end
      it { expect(response.status).to eq 302 }
      it { expect(flash[:error]).not_to be_present }
      it { expect(flash[:notice]).to be_present }
      it { expect(flash[:notice]).to eq 'Pet listed for adoption successfully!' }
      it { expect(response).to redirect_to action: :index }
    end

    context 'when name is blank' do
      before do
        pet_params[:pet][:name] = ''
        post :create, params: pet_params
      end
      it { expect(response.status).to eq 302 }
      it { expect(flash[:notice]).not_to be_present }
      it { expect(flash[:error]).to be_present }
      it { expect(flash[:error]).to eq ["Ops! There was a problem on your pet form!", "Name can't be blank"] }
      it { expect(response).to redirect_to action: :new }
    end

    context 'when breed is blank' do
      before do
        pet_params[:pet][:breed] = ''
        post :create, params: pet_params
      end
      it { expect(response.status).to eq 302 }
      it { expect(flash[:notice]).not_to be_present }
      it { expect(flash[:error]).to be_present }
      it { expect(flash[:error]).to eq ["Ops! There was a problem on your pet form!", "Breed can't be blank"] }
      it { expect(response).to redirect_to action: :new }
    end

    context 'when location is blank' do
      before do
        pet_params[:pet][:location] = ''
        post :create, params: pet_params
      end
      it { expect(response.status).to eq 302 }
      it { expect(flash[:notice]).not_to be_present }
      it { expect(flash[:error]).to be_present }
      it { expect(flash[:error]).to eq ["Ops! There was a problem on your pet form!", "Location can't be blank"] }
      it { expect(response).to redirect_to action: :new }
    end

    context 'when about is blank' do
      before do
        pet_params[:pet][:about] = ''
        post :create, params: pet_params
      end
      it { expect(response.status).to eq 302 }
      it { expect(flash[:notice]).not_to be_present }
      it { expect(flash[:error]).to be_present }
      it { expect(flash[:error]).to eq ["Ops! There was a problem on your pet form!", "About can't be blank"] }
      it { expect(response).to redirect_to action: :new }
    end
  end
end
