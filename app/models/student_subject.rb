class StudentSubject < ApplicationRecord
  has_many :points, dependent: :destroy

  belongs_to :class_subject
  belongs_to :student_classroom

  def name_subject
    class_subject.teacher.subject.name
  end

  def name_teacher
    class_subject.teacher.teacher.name
  end
end
