class Semester < ApplicationRecord
  belongs_to :school
  
  has_many :classrooms, dependent: :destroy

  validates :period, presence: true
  validates :start_date, :end_date, presence: true
  validates :school_year, presence: true, uniqueness: {scope: :period}
  validate :minus_not_greater_than_1
  validate :end_after_start

  scope :load_all_semesters?, (lambda do
    order(start_date: :desc)
    .select :id, :period, :start_date, :end_date, :school_year
  end)

  enum period: {hoc_ky_mot: 1, hoc_ky_hai: 2, hoc_ky_he: 3}

  def check_present?
    classrooms.present?
  end

  def get_period
    case period
    when "hoc_ky_he"
      3
    when "hoc_ky_hai"
      2
    else
      1
    end
  end

  private
  def end_after_start
    return if end_date.blank? || start_date.blank?
    errors.add(:end_date, I18n.t("semester.e_a_s")) if end_date < start_date
  end

  def minus_not_greater_than_1
    return if end_date.blank? || start_date.blank?
    errors.add(:base, I18n.t("semester.long_time")) if (end_date.year - start_date.year) > 1
  end
end
