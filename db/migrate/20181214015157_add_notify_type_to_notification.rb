class AddNotifyTypeToNotification < ActiveRecord::Migration[5.2]
  def change
    add_reference :notifications, :notify_type, foreign_key: true
  end
end
