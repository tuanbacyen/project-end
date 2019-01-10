class ClassSubject < ApplicationRecord
  has_many :timetables, dependent: :destroy
  has_many :student_subjects, dependent: :destroy
  has_many :examination_schedules, dependent: :destroy

  belongs_to :classroom
  belongs_to :teacher, class_name: :UserSubject, foreign_key: "user_subject_id"
end
