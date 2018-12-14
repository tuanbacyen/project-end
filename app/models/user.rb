class User < ApplicationRecord
  mount_uploader :avatar, AvatarUploader

  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :validatable, authentication_keys: [:login]

  attr_writer :login

  has_many :school_users, dependent: :destroy
  has_many :classrooms, dependent: :destroy
  has_many :class_subjects, dependent: :destroy
  has_many :students, dependent: :destroy
  has_many :attendances, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :day_offs, dependent: :destroy

  validates :name, presence: true
  validates :phone, presence: true

  enum role: {student_parent: 0, teacher: 1, manage: 2, admin: 3}

  def admin?
    role == "admin" && confirmed
  end

  def manage?
    role == "manage" && confirmed
  end

  def teacher?
    role == "teacher" && confirmed
  end

  def student_parent?
    role == "student_parent" && confirmed
  end

  def login
    @login || phone || email
  end

  def self.find_first_by_auth_conditions warden_conditions
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["lower(phone) = :value OR lower(email) = :value",
        {value: login.downcase}]).first
    elsif conditions[:username].nil?
      where(conditions).first
    else
      where(username: conditions[:username]).first
    end
  end
end
