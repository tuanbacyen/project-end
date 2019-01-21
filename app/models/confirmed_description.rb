class ConfirmedDescription < ApplicationRecord
  belongs_to :user
  belongs_to :school
  belongs_to :student
end
