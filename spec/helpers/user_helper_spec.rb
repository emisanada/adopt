require 'rails_helper'

describe UserHelper do
  describe '#user_admin?' do
    context 'when the user exists and is admin' do
      let(:user) { FactoryBot.build :user, id: 1, admin: true }
      it { expect(helper.user_admin?(user)).to be_truthy }
    end

    context 'when the user exists and isnt admin' do
      let(:user) { FactoryBot.build :user, id: 1 }
      it { expect(helper.user_admin?(user)).to be_falsey }
    end

    context 'when the user doesnt exist' do
      it { expect(helper.user_admin?(nil)).to be_falsey }
    end
  end
end
