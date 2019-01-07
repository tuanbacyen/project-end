class StudentClassroom < ApplicationRecord
  has_many :student_subjects, dependent: :destroy

  belongs_to :student
  belongs_to :classroom

  validate :student_in_semester

  private
  def student_in_semester
    return if student_id.blank? || classroom_id.blank?
    classrooms = student.student_classrooms.pluck(:classroom_id) << classroom_id
    c = Classroom.load_class_student(classrooms).pluck :semester_id
    errors.add(:base, "Học sinh đã ở một lớp khác trong học kỳ này") unless c.uniq.length == c.length
  end
end
