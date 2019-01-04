class Attendance < ApplicationRecord
  belongs_to :unit
  belongs_to :student
  belongs_to :teacher, class_name: :User, foreign_key: "user_id"
end
