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

ActiveRecord::Schema.define(version: 2022_10_30_010059) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "airlines", force: :cascade do |t|
    t.text "name"
    t.text "code"
    t.text "logo"
    t.text "country"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "flights", force: :cascade do |t|
    t.integer "flight_number"
    t.text "origin"
    t.text "destination"
    t.datetime "departure"
    t.datetime "arrival"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "airline_id"
  end

  create_table "tickets", force: :cascade do |t|
    t.float "price"
    t.text "class_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "flight_id"
    t.integer "user_id"
  end

  create_table "users", force: :cascade do |t|
    t.text "email"
    t.string "password_digest"
    t.text "first_name"
    t.text "last_name"
    t.float "balance"
    t.boolean "admin", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
