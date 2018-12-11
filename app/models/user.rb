class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :validatable, authentication_keys: [:login]

  attr_writer :login

  has_many :school_users, dependent: :destroy
  has_many :classrooms, dependent: :destroy
  has_many :class_subjects, dependent: :destroy
  has_many :students, dependent: :destroy
  has_many :attendances, dependent: :destroy
  has_many :comments, dependent: :destroy

  validates :name, presence: true
  validates :phone, presence: true

  enum role: {student_parent: 0, teacher: 1, manage: 2, admin: 3}

  def login
    @login || self.phone || self.email
  end

  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["lower(phone) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    else
      if conditions[:username].nil?
        where(conditions).first
      else
        where(username: conditions[:username]).first
      end
    end
  end  
end
