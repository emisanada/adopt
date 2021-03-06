# frozen_string_literal: true

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

  describe '#adopted_status' do
    context 'when the pet adopted is true' do
      let(:pet) { FactoryBot.build :pet, adopted: true }
      it { expect(helper.adopted_status(pet)).to eq 'Yes!!!' }
    end

    context 'when the pet adopted is false' do
      let(:pet) { FactoryBot.build :pet, adopted: false }
      it { expect(helper.adopted_status(pet)).to eq 'Waiting for a home' }
    end
  end

  describe '#adopted_icon' do
    context 'when the pet adopted is true' do
      let(:pet) { FactoryBot.build :pet, adopted: true }
      it { expect(helper.adopted_icon(pet)).to eq '<i class="fa fa-check-square-o"></i>' }
    end

    context 'when the pet adopted is false' do
      let(:pet) { FactoryBot.build :pet, adopted: false }
      it { expect(helper.adopted_icon(pet)).to eq '<i class="fa fa-square-o"></i>' }
    end
  end
end
