class Semester < ApplicationRecord
  has_many :classrooms, dependent: :destroy
  has_many :class_subjects, dependent: :destroy
end
