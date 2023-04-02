class User < ApplicationRecord
  has_secure_password

  # Board only can post
  has_many :posts

  # Board only can create weeks
  has_many :weeks

  # Board only can create contests
  has_many :contests
end
