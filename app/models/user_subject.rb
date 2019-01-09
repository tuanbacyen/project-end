class UserSubject < ApplicationRecord
  belongs_to :teacher, class_name: :User, foreign_key: "user_id"
  belongs_to :subject

  delegate :name, to: :teacher, prefix: true, allow_nil: true
  delegate :name, to: :subject, prefix: true, allow_nil: true
end
