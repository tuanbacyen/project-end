class UserSubject < ApplicationRecord
  belongs_to :teacher, class_name: :User, foreign_key: "user_id"
  belongs_to :subject

  has_many :class_subjects, dependent: :destroy

  validates_uniqueness_of :user_id, scope: :subject_id, message: "Giáo viên đã có môn học này"

  delegate :name, :usercode, to: :teacher, prefix: true, allow_nil: true
  delegate :name, to: :subject, prefix: true, allow_nil: true
end
