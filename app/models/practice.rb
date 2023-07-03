class Practice < ApplicationRecord
  belongs_to :trainee, class_name: "User", foreign_key: "trainee_id"
  belongs_to :contest, class_name: "Contest"
end
