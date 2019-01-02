class SchoolUser < ApplicationRecord
  belongs_to :school
  belongs_to :user

  validates :user_id, uniqueness: {scope: :school_id}
end
