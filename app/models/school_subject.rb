class SchoolSubject < ApplicationRecord
  belongs_to :school
  belongs_to :subject

  delegate :name, to: :subject, prefix: true, allow_nil: true

  validates :number, presence: true
end
