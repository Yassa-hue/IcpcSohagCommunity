class Contest < ApplicationRecord
  belongs_to :user
  has_many :practices, dependent: :destroy
end
