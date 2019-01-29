class User < ApplicationRecord
  mount_uploader :avatar, AvatarUploader

  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :validatable, authentication_keys: [:login]

  attr_writer :login

  has_many :school_users, dependent: :destroy
  has_many :classrooms, dependent: :destroy
  has_many :students, dependent: :destroy
  has_many :attendances, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :day_offs, dependent: :destroy
  has_many :user_subjects, dependent: :destroy
  has_many :confirmed_descriptions, dependent: :destroy

  validate :birth_not_than_today
  validates :email, presence: true, uniqueness: true, format: {with: Devise.email_regexp}
  validates :name, presence: true
  validates :phone, presence: true, uniqueness: true, length: {minimum: 10, maximum: 11},
                    format: {with: /\A(0)[8|9|3|7|5]\d{8,9}/}
  validates_length_of :identity_card, minimum: 9, maximum: 12,
                      numericality: {only_integer: true}, allow_blank: true
  validates_uniqueness_of :identity_card, allow_blank: true
  validates_uniqueness_of :usercode, allow_blank: true

  after_create :set_usercode_create
  before_update :set_usercode_update

  enum role: {student_parent: 0, teacher: 1, manage: 2, admin: 3}

  scope :load_users?, (lambda do
    order(updated_at: :desc)
    .select :id, :email, :phone, :name, :usercode, :identity_card, :gender, :address, :birth, :role, :avatar,
      :working, :confirmed
  end)

  scope :load_user_of_school, (lambda do |user|
    eager_load(:school_users).where("school_users.school_id in (?)", user.school_users.pluck(:school_id))
  end)

  scope :load_user_confirmed_of_school, (lambda do |user|
    eager_load(:confirmed_descriptions).where("confirmed_descriptions.school_id in (?)", user.school_users.pluck(:school_id))
  end)

  scope :load_teacher_of_school, (lambda do |school_id, ids|
    eager_load(:school_users, :user_subjects).where("school_users.school_id in (?) and users.id in (?)", school_id, ids)
  end)

  scope :user_has_classroom, (lambda do |semester_id|
    where.not(id: Classroom.where(semester_id: semester_id).pluck(:user_id)).uniq
  end)

  scope :load_manager, ->{where(role: 2)}

  scope :load_teacher, ->{where(role: 1)}

  scope :load_parent, ->{where(role: 0)}

  scope :is_working, ->{where(working: 1)}

  scope :last_code, ->{order(id: :asc).where.not(usercode: [nil, ""]).last.usercode[1..-1].to_i}

  scope :user_confirmed, (lambda do |confirmed|
    where(confirmed: confirmed)
  end)

  scope :user_less_than_role, (lambda do |current_user|
    where("role <= ?", current_user.get_role)
  end)

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

  def permission_create? current_user
    unless current_user.get_role > get_role && role != "admin"
      add_error_permission
      return true
    end
    false
  end

  def has_permission_edit? current_user, new_role
    (current_user.id == id && current_user.get_role == new_role) ||
      (current_user.get_role > get_role && new_role < current_user.get_role)
  end

  def can_show_list?
    role == "admin" || role == "manage"
  end

  def list_school
    school_users.pluck(:school_id)
  end

  def name_school
    if admin?
      "all school"
    else
      school_users.first.school.name
    end
  end

  def first_school
    school_users.first.school
  end

  def build_student
    school_users.first.school.students.build
  end

  def build_classroom
    school_users.first.school.classrooms.build
  end

  def get_confirmed
    confirmed_descriptions.first
  end

  def get_school_confirmed
    return confirmed_descriptions.first.school_id if confirmed_descriptions.present?
    nil
  end

  def manage_get_student
    school_users.first.school.students if manage?
  end

  def manage_get_classroom
    school_users.first.school.classrooms if manage?
  end

  def get_role
    case role
    when "admin"
      3
    when "manage"
      2
    when "teacher"
      1
    else
      0
    end
  end

  def add_error_permission
    errors.add(:base, "Ban Khong co quyen lam viec nay")
  end

  def it_me? user_request
    id == user_request.id
  end

  def it_me_or_role_equal_than_you? current_user
    it_me?(current_user) || role_equal_than_you?(current_user)
  end

  def role_equal_than_you? current_user
    get_role >= current_user.get_role
  end

  def role_than_you? current_user
    current_user.get_role > get_role
  end

  def it_me_or_admin? current_user
    role == "admin" || id == current_user.id
  end

  def admin_than_you? current_user
    current_user.role == "admin" && current_user.get_role > get_role && current_user.id != id
  end

  def default_password
    "#{format('%02d', birth.day)}#{format('%02d', birth.month)}#{birth.year}"
  end

  def check_present?
    school_users.present? || classrooms.present? || students.present? ||
      attendances.present? || comments.present? || day_offs.present? || user_subjects.present?
  end

  def update_gender
    update gender: nil
  end

  def age
    now = Time.now.utc.to_date
    now.year - birth.year -
      (now.month > birth.month || (now.month == birth.month && now.day >= birth.day) ? 0 : 1)
  end

  def struct_user?
    result = {
      name: name,
      email: email,
      phone: phone,
      identity_card: identity_card,
      gender: gender,
      address: address,
      birth: birth,
      role: role,
      working: working,
      avatar: avatar
    }
    result.to_json
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

  def update_working
    update working: false
  end

  def check_activitie_subject
    user_subjects.pluck(:subject_id).include? Subject.get_activitie.id
  end

  def get_activitie_subject
    user_subjects.find_by subject_id: Subject.get_activitie.id
  end

  def create_activitie_subject
    us = user_subjects.build
    us.subject_id = Subject.get_activitie.id
    us.save
  end
  private
  def birth_not_than_today
    return if birth.blank?
    errors.add(:base, "Birthday cannot equal than today") if age.negative? || birth.today?
  end

  def role_to_code
    rcode = if admin?
              "A"
            elsif manage?
              "M"
            elsif teacher?
              "T"
            else
              "P"
            end
    rcode
  end

  def set_usercode_create
    code = "#{role_to_code}#{User.last_code + 1}"
    update usercode: code
  end

  def set_usercode_update
    if role_changed? && usercode.present?
      self.usercode = "#{role_to_code}#{usercode[1..-1]}"
    elsif !usercode.present?
      self.usercode = "#{role_to_code}#{User.last_code + 1}"
    end
  end
end
