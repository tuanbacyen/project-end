class Classroom < ApplicationRecord
  has_many :class_subjects, dependent: :destroy
  has_many :student_classrooms, dependent: :destroy

  belongs_to :school
  belongs_to :semester
  belongs_to :teacher, class_name: :User, foreign_key: "user_id"

  delegate :name, to: :school, prefix: true, allow_nil: true
  delegate :school_year, to: :semester, prefix: true, allow_nil: true
  delegate :name, to: :teacher, prefix: true, allow_nil: true

  validates :name, presence: true
  validates :sizes, presence: true, inclusion: {in: 0..50, message: "%{value} is not a valid size"}
  validates :name, presence: true, length: {maximum: 10}
  validates_uniqueness_of :name, scope: :semester_id, message: "%{value} Đã tồn tại trong học kỳ"
  validates :user_id, presence: true
  validates_uniqueness_of :user_id, scope: :semester_id, message: "Đã giảng dạy trong học kỳ"

  after_create :create_activitie_for_teacher

  scope :load_all_classrooms, (lambda do |current_user|
    order(updated_at: :desc)
    .where(school_id: current_user.list_school)
    .select :id, :school_id, :semester_id, :user_id, :name, :sizes, :number
  end)

  scope :load_class_student, (lambda do |classroom_ids|
    where(id: classroom_ids)
  end)

  def show_classroom
    "(#{number}) #{name} / Học kỳ: #{semester.get_period} Năm Học: #{semester.school_year}"
  end

  def check_present?
    class_subjects.present? || student_classrooms.present?
  end

  def update_size
    update sizes: student_classrooms.size
  end

  private
  def create_activitie_for_teacher
    return if teacher.check_activitie_subject
    teacher.create_activitie_subject
  end
end
