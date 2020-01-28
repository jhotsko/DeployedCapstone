# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_01_28_022857) do

  create_table "articles", force: :cascade do |t|
    t.date "date"
    t.string "title"
    t.text "body"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "tag"
    t.string "file_file_name"
    t.string "file_content_type"
    t.integer "file_file_size"
    t.datetime "file_updated_at"
  end

  create_table "attendances", force: :cascade do |t|
    t.integer "attended"
    t.integer "cadet_id", null: false
    t.integer "event_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["cadet_id"], name: "index_attendances_on_cadet_id"
    t.index ["event_id"], name: "index_attendances_on_event_id"
  end

  create_table "cadets", force: :cascade do |t|
    t.string "lastName"
    t.string "firstName"
    t.string "email"
    t.string "phoneNumber"
    t.string "school"
    t.string "position"
    t.string "course"
    t.integer "gradYear"
    t.string "flight"
    t.string "username"
    t.string "password_digest"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "approved", default: false, null: false
    t.string "password_reset_token"
    t.datetime "password_reset_sent_at"
    t.string "image_file_name"
    t.string "image_content_type"
    t.integer "image_file_size"
    t.datetime "image_updated_at"
    t.index ["approved"], name: "index_cadets_on_approved"
  end

  create_table "events", force: :cascade do |t|
    t.date "eventDate"
    t.string "primaryType"
    t.string "subType"
    t.string "details"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "grades", force: :cascade do |t|
    t.integer "num_correct"
    t.integer "cadet_id", null: false
    t.integer "warriorknowledge_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["cadet_id"], name: "index_grades_on_cadet_id"
    t.index ["warriorknowledge_id"], name: "index_grades_on_warriorknowledge_id"
  end

  create_table "otscs", force: :cascade do |t|
    t.date "date"
    t.string "description"
    t.integer "cadet_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["cadet_id"], name: "index_otscs_on_cadet_id"
  end

  create_table "tasks", force: :cascade do |t|
    t.date "date_created"
    t.date "date_due"
    t.string "description"
    t.integer "cadet_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "completed"
    t.index ["cadet_id"], name: "index_tasks_on_cadet_id"
  end

  create_table "warriorknowledges", force: :cascade do |t|
    t.integer "num_questions"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.date "date_assigned"
    t.string "name"
    t.string "tag"
  end

  create_table "workouts", force: :cascade do |t|
    t.string "workoutType"
    t.date "workoutdate"
    t.integer "repititions"
    t.integer "distance"
    t.integer "cadet_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["cadet_id"], name: "index_workouts_on_cadet_id"
  end

  add_foreign_key "attendances", "cadets"
  add_foreign_key "attendances", "events"
  add_foreign_key "grades", "cadets"
  add_foreign_key "grades", "warriorknowledges"
  add_foreign_key "otscs", "cadets"
  add_foreign_key "tasks", "cadets"
  add_foreign_key "workouts", "cadets"
end
