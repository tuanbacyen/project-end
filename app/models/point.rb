class Point < ApplicationRecord
  belongs_to :point_type
  belongs_to :student_subject
end
