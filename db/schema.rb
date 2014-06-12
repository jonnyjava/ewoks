# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20140612090247) do

  create_table "fees", force: true do |t|
    t.string   "name"
    t.decimal  "price",      precision: 2, scale: 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "garage_id"
  end

  add_index "fees", ["garage_id"], name: "index_fees_on_garage_id"

  create_table "garage_properties", force: true do |t|
    t.string   "value"
    t.integer  "garage_id"
    t.integer  "property_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "garage_properties", ["garage_id"], name: "index_garage_properties_on_garage_id"
  add_index "garage_properties", ["property_id"], name: "index_garage_properties_on_property_id"

  create_table "garages", force: true do |t|
    t.string   "name"
    t.string   "address"
    t.string   "zip"
    t.string   "city"
    t.string   "email"
    t.string   "phone"
    t.string   "mobile"
    t.string   "fax"
    t.float    "latitude"
    t.float    "longitude"
    t.string   "tax_id"
    t.string   "website"
    t.string   "logo"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "country"
    t.integer  "owner_id"
    t.boolean  "enable"
  end

  create_table "holidays", force: true do |t|
    t.date     "start_date"
    t.date     "end_date"
    t.time     "start_time"
    t.time     "end_time"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "garage_id"
  end

  add_index "holidays", ["garage_id"], name: "index_holidays_on_garage_id"

  create_table "properties", force: true do |t|
    t.string   "name"
    t.string   "type_of"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tyre_fees", force: true do |t|
    t.integer  "vehicle_type"
    t.integer  "diameter_min"
    t.integer  "diameter_max"
    t.integer  "rim_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.string   "surname"
    t.string   "phone"
    t.integer  "country"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
