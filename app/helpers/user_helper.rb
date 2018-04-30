module UserHelper
  def user_admin?(user)
    user.present? && user.admin
  end
end
