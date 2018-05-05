# frozen_string_literal: true

class User < ActiveRecord::Base
  attr_accessor :password, :password_confirmation

  before_validation :encrypt_password
  after_save :clear_password

  EMAIL_REGEX = /[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}/i
  HARD_PASSWORD = /\A(?=.{8,})(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[[:^alnum:]])/x
  EASY_PASSWORD = /\A(?=.{6,})(?=.*\d)(?=.*[a-z])(?=.*[A-Z])/x

  validates :password,
            presence: true,
            length: { in: 6..25 },
            format: { with: EASY_PASSWORD },
            confirmation: true,
            on: :create
  validates :email,
            presence: true,
            uniqueness: true,
            format: EMAIL_REGEX
  validates :username,
            presence: true,
            uniqueness: true,
            length: { in: 3..25 }
  validates :name,
            presence: true,
            length: { in: 3..255 }
  validates :location,
            presence: true,
            length: { in: 3..255 }

  has_many :pets

  def self.authenticate(username = '', login_password = '')
    user = User.find_by_username(username)
    return user if user&.match_password(login_password)
    false
  end

  def match_password(login_password = '')
    encrypted_password == BCrypt::Engine.hash_secret(login_password, salt)
  end

  private

  def encrypt_password
    if password.present?
      self.salt = BCrypt::Engine.generate_salt
      self.encrypted_password = BCrypt::Engine.hash_secret(password, salt)
    end
  end

  def clear_password
    self.password = nil
  end
end
