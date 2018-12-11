class School < ApplicationRecord
  has_many :school_users, dependent: :destroy
  has_many :classrooms, dependent: :destroy
end
