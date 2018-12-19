class School < ApplicationRecord
  has_many :school_users, dependent: :destroy
  has_many :classrooms, dependent: :destroy

  validates :name, presence: true
  validates :address, presence: true
  validates :phone, presence: true

  scope :load_all_schools?, ->{select :id, :name, :address, :phone}

  def check_present?
    school_users.present? || classrooms.present?
  end
end
