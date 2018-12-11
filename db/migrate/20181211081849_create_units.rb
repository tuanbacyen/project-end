class CreateUnits < ActiveRecord::Migration[5.2]
  def change
    create_table :units do |t|
      t.time :time_start,       null: false
      t.time :time_end,         null: false

      t.timestamps
    end
  end
end
