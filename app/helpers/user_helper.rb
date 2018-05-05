# frozen_string_literal: true

module UserHelper
  def user_admin?(user)
    user.present? && user.admin
  end
end
