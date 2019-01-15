class PointType < ApplicationRecord
  has_many :points, dependent: :destroy
  has_many :examination_schedules, dependent: :destroy

  validates :name, presence: true, uniqueness: true
  validates :value, presence: true

  scope :load_all_point_types?, ->{select :id, :name, :value}

  def check_present?
    points.present? || examination_schedules.present?
  end
end
