class NotifyType < ApplicationRecord
  has_many :notifications, dependent: :destroy
end
