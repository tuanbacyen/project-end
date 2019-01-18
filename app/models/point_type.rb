class PointType < ApplicationRecord
  has_many :points, dependent: :destroy
  has_many :examination_schedules, dependent: :destroy

  validates :name, presence: true, uniqueness: true
  validates :value, presence: true

  scope :load_all_point_types?, ->{select :id, :name, :value}

  scope :point_mouth, ->{where(value: 1).first}
  scope :point_fifteen, ->{where(value: 1).last}
  scope :point_sixty, ->{where(value: 2).first}
  scope :point_finish, ->{where(value: 3).first}

  def check_present?
    points.present? || examination_schedules.present?
  end
end
