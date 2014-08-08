class User < ActiveRecord::Base
  has_secure_password

  validates :login, presence: true,
                    uniqueness: true,
                    length: (3..20),
                    format: /\A\w+\z/
  validates :password, length: {minimum: 7}
end
