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

ActiveRecord::Schema.define(version: 2020_08_20_034943) do

  create_table "logs", force: :cascade do |t|
    t.text "content"
    t.integer "plant_id"
    t.string "condition_update"
    t.string "watered_date"
  end

  create_table "plants", force: :cascade do |t|
    t.string "common_name"
    t.string "nickname"
    t.string "plant_type"
    t.integer "user_id"
  end

  create_table "tips", force: :cascade do |t|
    t.text "content"
    t.string "plant_type"
    t.string "care_category"
    t.integer "user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "name"
    t.string "password_digest"
    t.string "email"
  end

end
