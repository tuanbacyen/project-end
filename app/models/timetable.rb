class Timetable < ApplicationRecord
  belongs_to :class_subject
  belongs_to :unit
end
