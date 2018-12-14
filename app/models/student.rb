class Student < ApplicationRecord
  mount_uploader :avatar, AvatarUploader

  has_many :attendances, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :day_offs, dependent: :destroy
  has_many :student_subjects, dependent: :destroy

  belongs_to :classroom
  belongs_to :user, class_name: User.name, foreign_key: "parent"
end
