class AddStatusToFeedbacks < ActiveRecord::Migration[5.2]
  def change
    add_column :feedbacks, :status, :boolean, default: false
  end
end
