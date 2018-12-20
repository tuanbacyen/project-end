class Unit < ApplicationRecord
  has_many :attendances, dependent: :destroy
  has_many :timetables, dependent: :destroy
  has_many :examination_schedules, dependent: :destroy
  validates :numunit, presence: true, uniqueness: true
  validates :time_start, presence: true, uniqueness: true
  validates :time_end, presence: true, uniqueness: true
  validate :end_after_start

  scope :load_all_units?, ->{select :id, :numunit, :time_start, :time_end}

  def check_present?
    attendances.present? || timetables.present? || examination_schedules.present?
  end

  private
  def end_after_start
    return if time_start.blank? || time_end.blank?
    errors.add(:time_end, I18n.t("unit.e_a_s")) if time_end < time_start
  end
end
