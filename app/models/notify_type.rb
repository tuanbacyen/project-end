class NotifyType < ApplicationRecord
  has_many :notifications, dependent: :destroy
  validates :name, presence: true, uniqueness: true

  scope :load_all_notify_types?, (lambda do
    order(name: :asc)
    .select :id, :name
  end)

  def check_present?
    notifications.present?
  end
end
