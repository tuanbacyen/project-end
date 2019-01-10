class Subject < ApplicationRecord
  has_many :user_subjects, dependent: :destroy

  validates :name, presence: true, uniqueness: true

  scope :load_all_subjects?, (lambda do
    order(name: :asc)
    .select :id, :name
  end)

  scope :list_subject_exists?, ->{pluck :name}

  def check_present?
    class_subjects.present?
  end
end
