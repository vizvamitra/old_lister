class User < ActiveRecord::Base
  has_secure_password

  validates :login, presence: true,
                    uniqueness: {:case_sensitive => false},
                    length: {maximum: 30},
                    format: /\A\w+\z/
  validates :password, length: {minimum: 7}

  before_save { login.downcase }
end
