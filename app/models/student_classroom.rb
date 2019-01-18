class StudentClassroom < ApplicationRecord
  has_many :student_subjects, dependent: :destroy

  belongs_to :student
  belongs_to :classroom

  validate :student_in_semester

  delegate :name, to: :student, prefix: true, allow_nil: true
  delegate :name, to: :classroom, prefix: true, allow_nil: true

  after_create :set_size, :create_student_subject
  after_destroy :set_size

  private
  def student_in_semester
    return if student_id.blank? || classroom_id.blank?
    classrooms = student.student_classrooms.pluck(:classroom_id) << classroom_id
    c = Classroom.load_class_student(classrooms).pluck :semester_id
    errors.add(:base, "Học sinh đã ở một lớp khác trong học kỳ này") unless c.uniq.length == c.length
  end

  def set_size
    Classroom.find_by(id: classroom_id).update_size
  end

  def create_student_subject
    ClassSubject.where(classroom_id: classroom_id).each do |class_subject|
      ss = class_subject.student_subjects.build
      ss.student_classroom_id = id
      ss.save
    end
  end
end
