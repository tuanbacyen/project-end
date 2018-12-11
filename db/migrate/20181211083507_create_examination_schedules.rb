class CreateExaminationSchedules < ActiveRecord::Migration[5.2]
  def change
    create_table :examination_schedules do |t|
      t.date :exam_date,      null: false, default: DateTime.now.strftime("%Y-%d-%m")
      
      t.references :class_subject, foreign_key: true, null: false
      t.references :point_type, foreign_key: true, null: false
      t.references :unit, foreign_key: true, null: false

      t.timestamps
    end
  end
end
