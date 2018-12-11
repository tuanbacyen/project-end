class PointType < ApplicationRecord
  has_many :points, dependent: :destroy
  has_many :examination_schedules, dependent: :destroy
end
