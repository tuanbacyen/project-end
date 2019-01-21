class Student < ApplicationRecord
  mount_uploader :avatar, AvatarUploader

  has_many :attendances, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :day_offs, dependent: :destroy
  has_many :student_classrooms, dependent: :destroy
  has_many :confirmed_descriptions, dependent: :destroy

  belongs_to :parent, class_name: :User, foreign_key: "user_id", optional: true
  belongs_to :school

  validate :birth_not_than_today
  validates :student_code, presence: true, uniqueness: true
  validates :name, presence: true
  validates :birth, presence: true
  validates :address, presence: true
  validates :phone, length: {minimum: 10, maximum: 11}, format: {with: /\A(0)[8|9|3|7|5]\d{8,9}/}

  delegate :name, :phone, to: :parent, prefix: true, allow_nil: true

  scope :load_all_students, (lambda do
    order(created_at: :desc)
    .select :id, :student_code, :name, :birth, :address, :favorite, :phone, :father_name,
      :father_phone, :mother_name, :mother_phone, :user_id, :avatar, :studying
  end)

  scope :load_student_in_class, (lambda do |class_id|
    eager_load(:student_classrooms).where("student_classrooms.classroom_id in (?)", class_id)
  end)

  scope :student_no_parent, ->{where(user_id: nil)}

  def check_present?
    attendances.present? || comments.present? || day_offs.present? || student_classrooms.present?
  end

  def age
    now = Time.now.utc.to_date
    now.year - birth.year -
      (now.month > birth.month || (now.month == birth.month && now.day >= birth.day) ? 0 : 1)
  end

  private
  def birth_not_than_today
    return if birth.blank?
    errors.add(:base, "Birthday cannot equal than today") if age.negative? || birth.today?
  end
end
