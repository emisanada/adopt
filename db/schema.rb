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

ActiveRecord::Schema.define(version: 2018_04_30_052021) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "models", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_models_on_email", unique: true
    t.index ["reset_password_token"], name: "index_models_on_reset_password_token", unique: true
  end

  create_table "pets", force: :cascade do |t|
    t.string "name", limit: 25, null: false
    t.string "breed", limit: 255, null: false
    t.string "age", limit: 255, default: "", null: false
    t.boolean "status", null: false
    t.string "location", limit: 255, default: "", null: false
    t.integer "user_id", null: false
    t.string "picture", limit: 255, default: "", null: false
    t.string "about", limit: 255, default: "", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", limit: 255, null: false
    t.string "name", limit: 255, null: false
    t.string "username", limit: 25, null: false
    t.string "encrypted_password", null: false
    t.string "location", limit: 255, default: "", null: false
    t.string "about", limit: 255, default: "", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "salt"
    t.boolean "admin", default: false, null: false
  end

end
