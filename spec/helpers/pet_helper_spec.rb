require 'rails_helper'

describe PetHelper do
  describe '#pet_owner?' do
    context 'when the user exists and is admin' do
      let(:user) { FactoryBot.build :user, id: 1, admin: true }
      let(:pet) { FactoryBot.build :pet, user_id: 1 }
      it { expect(helper.pet_owner?(user, pet)).to be_truthy }
    end

    context 'when the user exists and is owner' do
      let(:user) { FactoryBot.build :user, id: 1 }
      let(:pet) { FactoryBot.build :pet, user_id: 1 }
      it { expect(helper.pet_owner?(user, pet)).to be_truthy }
    end

    context 'when the user exists and isnt owner' do
      let(:user) { FactoryBot.build :user, id: 1 }
      let(:pet) { FactoryBot.build :pet, user_id: 2 }
      it { expect(helper.pet_owner?(user, pet)).to be_falsey }
    end

    context 'when the user doesnt exist' do
      let(:pet) { FactoryBot.build :pet, user_id: 1 }
      it { expect(helper.pet_owner?(nil, pet)).to be_falsey }
    end

    context 'when the pet doesnt exist' do
      let(:user) { FactoryBot.build :user, id: 1 }
      it { expect(helper.pet_owner?(user, nil)).to be_falsey }
    end

    context 'when both the user and pet doesnt exist' do
      it { expect(helper.pet_owner?(nil, nil)).to be_falsey }
    end
  end
end
