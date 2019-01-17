class Point < ApplicationRecord
  belongs_to :point_type
  belongs_to :student_subject

  delegate :name, to: :point_type, prefix: true, allow_nil: true

  validates :point, presence: true, inclusion: {in: 0..10, message: "%{value} is not a valid size"}
end
