class ClassSubject < ApplicationRecord
  has_many :timetables, dependent: :destroy
  has_many :student_subjects, dependent: :destroy
  has_many :examination_schedules, dependent: :destroy

  belongs_to :subject
  belongs_to :semester
  belongs_to :classroom
  belongs_to :teacher, class_name: :User, foreign_key: "user_id"
end
