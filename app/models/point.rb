class Point < ApplicationRecord
  belongs_to :point_type
  belongs_to :student_subject

  delegate :name, to: :point_type, prefix: true, allow_nil: true

  validates :point, presence: true, inclusion: {in: 0..10, message: "%{value} is not a valid size"}

  after_create :update_student_subject
  after_update :update_student_subject
  after_destroy :update_student_subject

  scope :load_point_mouth, (lambda do
    where(point_type_id: PointType.point_mouth.id)
  end)

  scope :load_point_fifteen, (lambda do
    where(point_type_id: PointType.point_fifteen.id)
  end)

  scope :load_point_sixty, (lambda do
    where(point_type_id: PointType.point_sixty.id)
  end)

  scope :load_point_finish, (lambda do
    where(point_type_id: PointType.point_finish.id)
  end)

  private
  def update_student_subject
    StudentSubject.find_by(id: student_subject_id).update_average
  end
end
