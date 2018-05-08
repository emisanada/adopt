require "spec_helper"

describe User do
  let(:user) { FactoryBot.build :user_admin }
  before do
    user.save
  end

  describe '#match_password' do
    context 'when password is correct' do
      let(:password) { 'Sh3ikah' }

      it { expect(user.match_password(password)).to be_truthy }
    end

    context 'when password is incorrect' do
      let(:password) { 'Link3Force' }

      it { expect(user.match_password(password)).to be_falsey }
    end
  end

  describe '.authenticate' do
    context 'when username and password are correct' do
      let(:username) { 'pzelda' }
      let(:password) { 'Sh3ikah' }

      it { expect(User.authenticate(username, password).name).to eq user.name }
      it { expect(User.authenticate(username, password).email).to eq user.email }
      it { expect(User.authenticate(username, password).location).to eq user.location }
      it { expect(User.authenticate(username, password).about).to eq user.about }
      it { expect(User.authenticate(username, password).username).to eq user.username }
      it { expect(User.authenticate(username, password).admin).to eq user.admin }
    end

    context 'when username is incorrect' do
      let(:username) { 'princesszelda' }
      let(:password) { 'Sh3ikah' }

      it { expect(User.authenticate(username, password)).to be_falsey }
    end

    context 'when password is incorrect' do
      let(:username) { 'pzelda' }
      let(:password) { 'Zelda' }

      it { expect(User.authenticate(username, password)).to be_falsey }
    end
  end

end
