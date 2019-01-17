class Point < ApplicationRecord
  belongs_to :point_type
  belongs_to :student_subject

  delegate :name, to: :point_type, prefix: true, allow_nil: true  
end
