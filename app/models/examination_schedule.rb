class ExaminationSchedule < ApplicationRecord
  belongs_to :class_subject
  belongs_to :point_type
  belongs_to :unit
end
