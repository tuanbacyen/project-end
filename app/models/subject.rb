class Subject < ApplicationRecord
  has_many :user_subjects, dependent: :destroy
  has_many :school_subjects, dependent: :destroy

  validates :name, presence: true, uniqueness: true
  validates :subject_code, presence: true, uniqueness: true

  scope :load_all_subjects?, (lambda do
    order(name: :asc)
    .select :id, :name, :subject_code
  end)
  
  scope :get_activitie, ->{find_by subject_code: Settings.list_code_subject.last}

  scope :list_subject_exists?, ->{pluck :name}

  def list_teacher
    user_subjects.uniq.pluck :user_id
  end

  def check_present?
    user_subjects.present? || school_subjects.present?
  end
end
