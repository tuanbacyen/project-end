class CreateNotifyTypes < ActiveRecord::Migration[5.2]
  def change
    create_table :notify_types do |t|
      t.string :name,           null: false

      t.timestamps
    end
  end
end
