class User < ActiveRecord::Base
  attr_accessor :password

  before_validation :encrypt_password
  after_save :clear_password

  EMAIL_REGEX = /[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}/i
  validates :email, presence: true, uniqueness: true, format: EMAIL_REGEX
  validates :username, presence: true, uniqueness: true, length: { in: 3..25 }
  validates :password, confirmation: true
  validates_length_of :password, in: 6..20, on: :create

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
