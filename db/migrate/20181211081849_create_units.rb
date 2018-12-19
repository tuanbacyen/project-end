class CreateUnits < ActiveRecord::Migration[5.2]
  def change
    create_table :units do |t|
      t.string :time_start,       null: false
      t.string :time_end,         null: false

      t.timestamps
    end
  end
end
