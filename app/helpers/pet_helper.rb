module PetHelper
  def pet_owner?(user, pet)
    user.present? && pet.present? && (user.admin || pet.user_id == user.id)
  end
end
