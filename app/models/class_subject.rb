class ClassSubject < ApplicationRecord
  has_many :timetables, dependent: :destroy
  has_many :student_subjects, dependent: :destroy
  has_many :examination_schedules, dependent: :destroy

  belongs_to :subject
  belongs_to :semester
  belongs_to :classroom
  belongs_to :user, class_name: User.name, foreign_key: "teacher"
end
