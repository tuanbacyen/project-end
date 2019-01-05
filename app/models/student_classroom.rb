class StudentClassroom < ApplicationRecord
  has_many :student_subjects, dependent: :destroy

  belongs_to :student
  belongs_to :classroom
end
