require 'spec_helper'
require 'rails_helper'

describe UsersController do

  let(:user_params) do
    {
      user: {
        name: 'Lena Oxton',
        email: 'tracer@overwatch.com',
        location: 'London',
        username: 'tracer',
        password: 'C4valry1sHere',
        password_confirmation: 'C4valry1sHere'
      }
    }
  end

  describe '.create' do
    context 'when successfully create user' do
      before do
        post :create, params: user_params
      end
      it { expect(response.status).to eq 302 }
      it { expect(flash[:error]).not_to be_present }
      it { expect(flash[:notice]).to be_present }
      it { expect(flash[:notice]).to eq 'You signed up successfully!' }
      it { expect(response).to redirect_to root_path }
    end

    context 'when password is invalid' do
      before do
        user_params[:user][:password] = '123'
        post :create, params: user_params
      end
      it { expect(response.status).to eq 400 }
      it { expect(flash[:notice]).not_to be_present }
      it { expect(response).to render_template :new }
    end

    context 'when username is invalid' do
      before do
        user_params[:user][:username] = 'tr'
        post :create, params: user_params
      end
      it { expect(response.status).to eq 400 }
      it { expect(flash[:notice]).not_to be_present }
      it { expect(response).to render_template :new }
    end

    context 'when name is blank' do
      before do
        user_params[:user][:name] = ''
        post :create, params: user_params
      end
      it { expect(response.status).to eq 400 }
      it { expect(flash[:notice]).not_to be_present }
      it { expect(response).to render_template :new }
    end

    context 'when location is blank' do
      before do
        user_params[:user][:location] = ''
        post :create, params: user_params
      end
      it { expect(response.status).to eq 400 }
      it { expect(flash[:notice]).not_to be_present }
      it { expect(response).to render_template :new }
    end

    context 'when e-mail is invalid' do
      before do
        user_params[:user][:email] = 'help'
        post :create, params: user_params
      end
      it { expect(response.status).to eq 400 }
      it { expect(flash[:notice]).not_to be_present }
      it { expect(response).to render_template :new }
    end
  end

  describe '.update' do
    before do
      allow_any_instance_of(ApplicationController).to receive(:authenticate_user).and_return(true)
      allow_any_instance_of(ApplicationController).to receive(:check_current_user).and_return(true)
      allow(User).to receive(:find).and_return(user)
    end
    let(:user) { FactoryBot.build :user, id: 1 }

    context 'when successfully update user' do
      before do
        patch :update, params: { id: user.id, user: user_params[:user] }
      end
      it { expect(response.status).to eq 302 }
      it { expect(flash[:error]).not_to be_present }
      it { expect(flash[:notice]).to be_present }
      it { expect(flash[:notice]).to eq 'Your changes were saved! Whoof!' }
      it { expect(response).to redirect_to action: :show }
    end

    context 'when name is too short' do
      before do
        user_params[:user][:name] = ''
        patch :update, params: { id: user.id, user: user_params[:user] }
      end
      it { expect(response.status).to eq 400 }
      it { expect(flash[:notice]).not_to be_present }
      it { expect(response).to render_template :edit }
    end

    context 'when e-mail is invalid' do
      before do
        user_params[:user][:email] = 'wrong@email'
        patch :update, params: { id: user.id, user: user_params[:user] }
      end
      it { expect(response.status).to eq 400 }
      it { expect(flash[:notice]).not_to be_present }
      it { expect(response).to render_template :edit }
    end

    context 'when location is blank' do
      before do
        user_params[:user][:location] = ''
        patch :update, params: { id: user.id, user: user_params[:user] }
      end
      it { expect(response.status).to eq 400 }
      it { expect(flash[:notice]).not_to be_present }
      it { expect(response).to render_template :edit }
    end

    context 'when cant update different user' do
      before do
        allow_any_instance_of(ApplicationController).to receive(:check_current_user).and_call_original
        patch :update, params: { id: user.id, user: user_params[:user] }
      end
      it { expect(response.status).to eq 302 }
      it { expect(flash[:notice]).not_to be_present }
      it { expect(flash[:error]).to be_present }
      it { expect(flash[:error]).to eq 'Restricted area! Paws off!' }
      it { expect(response).to redirect_to root_path }
    end
  end

  describe '.destroy' do
    before do
      allow_any_instance_of(ApplicationController).to receive(:authenticate_user).and_return(true)
      allow_any_instance_of(ApplicationController).to receive(:check_current_user).and_return(true)
      allow(User).to receive(:find).and_return(user)
      allow(User).to receive(:all).and_return(nil)
    end
    let(:user) { FactoryBot.build :user, id: 1 }

    context 'when successfully delete user' do
      before do
        delete :destroy, params: { id: user.id, user: user_params[:user] }
      end
      it { expect(response.status).to eq 302 }
      it { expect(flash[:error]).not_to be_present }
      it { expect(response).to redirect_to root_path }
    end

    context 'when cant delete different user' do
      before do
        allow_any_instance_of(ApplicationController).to receive(:check_current_user).and_call_original
        delete :destroy, params: { id: user.id, user: user_params[:user] }
      end
      it { expect(response.status).to eq 302 }
      it { expect(flash[:notice]).not_to be_present }
      it { expect(flash[:error]).to be_present }
      it { expect(flash[:error]).to eq 'Restricted area! Paws off!' }
      it { expect(response).to redirect_to root_path }
    end
  end

  describe '.index' do
    before do
      allow_any_instance_of(ApplicationController).to receive(:admin_access).and_return(true)
      allow(User).to receive(:find).and_return(user)
    end

    context 'when there is one user' do
      let(:user) { FactoryBot.build :user, id: 1 }
      before do
        get :index
      end
      it { expect(response.status).to eq 200 }
      it { expect(response).to render_template 'index' }
    end

    context 'when user is not admin' do
      let(:user) { FactoryBot.build :user, id: 1 }
      before do
        allow_any_instance_of(ApplicationController).to receive(:admin_access).and_call_original
        get :index
      end
      it { expect(response.status).to eq 302 }
      it { expect(response).to redirect_to root_path }
    end
  end
end
