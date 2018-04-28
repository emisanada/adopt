class User < ActiveRecord::Base
  attr_accessor :password, :password_confirmation

  before_validation :encrypt_password
  after_save :clear_password

  EMAIL_REGEX = /[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}/i
  PASSWORD_FORMAT = /\A(?=.{8,})(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[[:^alnum:]])/x

  validates :password,
    presence: true,
    length: { in: 8..25 },
    format: { with: PASSWORD_FORMAT },
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

  has_many :pets

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
