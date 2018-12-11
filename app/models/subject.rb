class Subject < ApplicationRecord
  has_many :class_subjects, dependent: :destroy
end
