# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_01_10_041417) do

  create_table "attendances", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.date "day_check", null: false
    t.string "reason", default: ""
    t.boolean "confirmed", default: false
    t.bigint "unit_id", null: false
    t.bigint "student_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["student_id"], name: "index_attendances_on_student_id"
    t.index ["unit_id"], name: "index_attendances_on_unit_id"
    t.index ["user_id"], name: "index_attendances_on_user_id"
  end

  create_table "class_subjects", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "classroom_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_subject_id"
    t.index ["classroom_id"], name: "index_class_subjects_on_classroom_id"
    t.index ["user_subject_id"], name: "index_class_subjects_on_user_subject_id"
  end

  create_table "classrooms", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "school_id", null: false
    t.bigint "semester_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.integer "sizes"
    t.integer "number"
    t.index ["school_id"], name: "index_classrooms_on_school_id"
    t.index ["semester_id"], name: "index_classrooms_on_semester_id"
    t.index ["user_id"], name: "index_classrooms_on_user_id"
  end

  create_table "comments", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "content", default: "", null: false
    t.integer "parent_id"
    t.bigint "student_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["student_id"], name: "index_comments_on_student_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "day_offs", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.date "date_off", default: "2019-05-01"
    t.string "reason", default: "", null: false
    t.boolean "confirmed", default: false
    t.bigint "student_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.index ["student_id"], name: "index_day_offs_on_student_id"
    t.index ["user_id"], name: "index_day_offs_on_user_id"
  end

  create_table "examination_schedules", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.date "exam_date", null: false
    t.bigint "class_subject_id", null: false
    t.bigint "point_type_id", null: false
    t.bigint "unit_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["class_subject_id"], name: "index_examination_schedules_on_class_subject_id"
    t.index ["point_type_id"], name: "index_examination_schedules_on_point_type_id"
    t.index ["unit_id"], name: "index_examination_schedules_on_unit_id"
  end

  create_table "feedbacks", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "from_id", null: false
    t.string "content", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "status", default: false
  end

  create_table "notifications", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "from_id", null: false
    t.integer "to_id", null: false
    t.string "content", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "notify_type_id"
    t.index ["notify_type_id"], name: "index_notifications_on_notify_type_id"
  end

  create_table "notify_types", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "point_types", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name", null: false
    t.float "value", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "points", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.float "point", default: 0.0
    t.bigint "point_type_id", null: false
    t.bigint "student_subject_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["point_type_id"], name: "index_points_on_point_type_id"
    t.index ["student_subject_id"], name: "index_points_on_student_subject_id"
  end

  create_table "school_users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "school_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["school_id"], name: "index_school_users_on_school_id"
    t.index ["user_id"], name: "index_school_users_on_user_id"
  end

  create_table "schools", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name", null: false
    t.string "address", null: false
    t.string "phone", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "semesters", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "period", null: false
    t.date "start_date", null: false
    t.date "end_date", null: false
    t.string "school_year", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "student_classrooms", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "student_id", null: false
    t.bigint "classroom_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["classroom_id"], name: "index_student_classrooms_on_classroom_id"
    t.index ["student_id"], name: "index_student_classrooms_on_student_id"
  end

  create_table "student_subjects", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.float "average", default: 0.0
    t.float "average_total", default: 0.0
    t.string "classification", default: "F"
    t.bigint "class_subject_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "student_classroom_id"
    t.index ["class_subject_id"], name: "index_student_subjects_on_class_subject_id"
    t.index ["student_classroom_id"], name: "index_student_subjects_on_student_classroom_id"
  end

  create_table "students", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "student_code", null: false
    t.date "birth", null: false
    t.string "address", null: false
    t.string "favorite", default: ""
    t.string "phone", default: ""
    t.string "father_name", default: ""
    t.string "father_phone", default: ""
    t.string "mother_name", default: ""
    t.string "mother_phone", default: ""
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "avatar"
    t.boolean "studying", default: true
    t.string "name", null: false
    t.bigint "user_id"
    t.bigint "school_id"
    t.index ["school_id"], name: "index_students_on_school_id"
    t.index ["user_id"], name: "index_students_on_user_id"
  end

  create_table "subjects", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_subjects_on_name", unique: true
  end

  create_table "timetables", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name", null: false
    t.integer "day", null: false
    t.bigint "class_subject_id", null: false
    t.bigint "unit_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["class_subject_id"], name: "index_timetables_on_class_subject_id"
    t.index ["unit_id"], name: "index_timetables_on_unit_id"
  end

  create_table "ulogs", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "form_user", null: false
    t.integer "action", null: false
    t.string "content", null: false
    t.string "new"
    t.string "old"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "units", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "time_start", null: false
    t.string "time_end", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "numunit"
  end

  create_table "user_subjects", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "subject_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["subject_id"], name: "index_user_subjects_on_subject_id"
    t.index ["user_id"], name: "index_user_subjects_on_user_id"
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "phone", default: "", null: false
    t.string "name", default: "", null: false
    t.string "identity_card", default: ""
    t.boolean "gender"
    t.string "address", default: ""
    t.date "birth", default: "1980-01-01"
    t.integer "role", default: 0, null: false
    t.boolean "confirmed", default: false, null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "avatar"
    t.boolean "working", default: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["phone"], name: "index_users_on_phone", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "attendances", "students"
  add_foreign_key "attendances", "units"
  add_foreign_key "attendances", "users"
  add_foreign_key "class_subjects", "classrooms"
  add_foreign_key "class_subjects", "user_subjects"
  add_foreign_key "classrooms", "schools"
  add_foreign_key "classrooms", "semesters"
  add_foreign_key "classrooms", "users"
  add_foreign_key "comments", "students"
  add_foreign_key "comments", "users"
  add_foreign_key "day_offs", "students"
  add_foreign_key "day_offs", "users"
  add_foreign_key "examination_schedules", "class_subjects"
  add_foreign_key "examination_schedules", "point_types"
  add_foreign_key "examination_schedules", "units"
  add_foreign_key "notifications", "notify_types"
  add_foreign_key "points", "point_types"
  add_foreign_key "points", "student_subjects"
  add_foreign_key "school_users", "schools"
  add_foreign_key "school_users", "users"
  add_foreign_key "student_classrooms", "classrooms"
  add_foreign_key "student_classrooms", "students"
  add_foreign_key "student_subjects", "class_subjects"
  add_foreign_key "student_subjects", "student_classrooms"
  add_foreign_key "students", "schools"
  add_foreign_key "students", "users"
  add_foreign_key "timetables", "class_subjects"
  add_foreign_key "timetables", "units"
  add_foreign_key "user_subjects", "subjects"
  add_foreign_key "user_subjects", "users"
end
