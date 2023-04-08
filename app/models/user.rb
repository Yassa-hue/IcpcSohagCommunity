class User < ApplicationRecord
  has_secure_password

  # Board only can post
  has_many :posts

  # Board only can create weeks
  has_many :weeks

  # Board only can create contests
  has_many :contests


  has_many :tasks

  # A practice is tracking how much problems this trainee solved from a particular contest.
  # This record it updated AUTOMATICALLY using codeforces api.
  has_many :practices, foreign_key: "trainee_id"
end
