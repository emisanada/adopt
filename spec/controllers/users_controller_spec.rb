require 'spec_helper'
require 'rails_helper'

describe UsersController do

  describe '.create' do
    let(:user_params) do
      {
        user: {
          name: 'Test',
          email: 'email@email.com',
          location: 'Canada',
          username: 'test123',
          password: '123ABCabc',
          password_confirmation: '123ABCabc'
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

    context 'when password invalid' do
      before do
        user_params[:user][:password] = '123'
        post :create, params: user_params
      end
      it { expect(response.status).to eq 302 }
      it { expect(flash[:notice]).not_to be_present }
      it { expect(flash[:error]).to be_present }
      it { expect(flash[:error]).to eq ["Ops! There was a problem on your signup!", "Password is too short (minimum is 6 characters)", "Password is invalid", "Password confirmation doesn't match Password"] }
      it { expect(response).to redirect_to action: :new }
    end
  end
end
