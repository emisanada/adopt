require 'spec_helper'
require 'rails_helper'

describe UsersController do

  describe '.create' do
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

    context 'when success' do
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

    context 'when email is invalid' do
      before do
        user_params[:user][:email] = 'help'
        post :create, params: user_params
      end
      it { expect(response.status).to eq 400 }
      it { expect(flash[:notice]).not_to be_present }
      it { expect(response).to render_template :new }
    end
  end
end
