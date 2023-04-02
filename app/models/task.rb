class Task < ApplicationRecord
  belongs_to :coach, class_name: "User"
  belongs_to :trainee, class_name: "User"
end
