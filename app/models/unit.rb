class Unit < ApplicationRecord
  has_many :attendances, dependent: :destroy
  has_many :timetables, dependent: :destroy
  has_many :examination_schedules, dependent: :destroy
end
