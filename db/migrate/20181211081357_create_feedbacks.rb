class CreateFeedbacks < ActiveRecord::Migration[5.2]
  def change
    create_table :feedbacks do |t|
      t.integer :from_id,         null: false
      t.string :content,          null: false

      t.timestamps
    end
  end
end
