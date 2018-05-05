# frozen_string_literal: true

module PetHelper
  def pet_owner?(user, pet)
    user.present? && pet.present? && (user.admin || pet.user_id == user.id)
  end

  def adopted_status(pet)
    pet.adopted ? 'Yes!!!' : 'Waiting for a home'
  end

  def adopted_icon(pet)
    pet.adopted ? fa_icon('check-square-o') : fa_icon('square-o')
  end
end
