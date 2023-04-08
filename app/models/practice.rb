class Practice < ApplicationRecord
  belongs_to :trainee, class_name: "User"
  belongs_to :contest, class_name: "Contest"
end
