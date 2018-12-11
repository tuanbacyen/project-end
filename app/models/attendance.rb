class Attendance < ApplicationRecord
  belongs_to :unit
  belongs_to :student
  belongs_to :user, class_name: User.name, foreign_key: "teacher"
end
