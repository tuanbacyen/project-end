class StudentSubject < ApplicationRecord
  has_many :points, dependent: :destroy

  belongs_to :class_subject
  belongs_to :student
end
