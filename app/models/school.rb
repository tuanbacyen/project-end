class School < ApplicationRecord
  has_many :school_users, dependent: :destroy
  has_many :classrooms, dependent: :destroy
  has_many :students, dependent: :destroy
  has_many :confirmed_descriptions, dependent: :destroy

  validates :name, presence: true
  validates :address, presence: true
  validates :phone, presence: true, uniqueness: true, length: {minimum: 10, maximum: 11},
                    format: {with: /\A(0)[8|9|3|7|5]\d{8,9}/}

  scope :load_all_schools?, ->{select :id, :name, :address, :phone}

  def check_present?
    school_users.present? || classrooms.present?
  end
end
