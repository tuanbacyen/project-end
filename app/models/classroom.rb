class Classroom < ApplicationRecord
  has_many :class_subjects, dependent: :destroy
  has_many :students, dependent: :destroy

  belongs_to :school
  belongs_to :semester
  belongs_to :user, class_name: User.name, foreign_key: "teacher"
end
