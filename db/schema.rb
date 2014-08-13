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

ActiveRecord::Schema.define(version: 20140813130709) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "garage_properties", force: true do |t|
    t.text     "value"
    t.integer  "garage_id"
    t.integer  "property_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "garage_properties", ["garage_id"], name: "index_garage_properties_on_garage_id", using: :btree
  add_index "garage_properties", ["property_id"], name: "index_garage_properties_on_property_id", using: :btree

  create_table "garages", force: true do |t|
    t.text     "name"
    t.text     "street"
    t.text     "zip"
    t.text     "city"
    t.text     "email"
    t.text     "phone"
    t.text     "mobile"
    t.text     "fax"
    t.decimal  "latitude",          precision: 9, scale: 6
    t.decimal  "longitude",         precision: 9, scale: 6
    t.text     "tax_id"
    t.text     "website"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "country"
    t.integer  "owner_id"
    t.integer  "status",                                    default: -1
    t.text     "logo_file_name"
    t.text     "logo_content_type"
    t.integer  "logo_file_size"
    t.datetime "logo_updated_at"
  end

  create_table "holidays", force: true do |t|
    t.date     "start_date"
    t.date     "end_date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "garage_id"
    t.text     "name"
  end

  add_index "holidays", ["garage_id"], name: "index_holidays_on_garage_id", using: :btree

  create_table "properties", force: true do |t|
    t.text     "name"
    t.text     "type_of"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "timetables", force: true do |t|
    t.integer  "garage_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.time     "mon_morning_open"
    t.time     "mon_morning_close"
    t.time     "mon_afternoon_open"
    t.time     "mon_afternoon_close"
    t.time     "tue_morning_open"
    t.time     "tue_morning_close"
    t.time     "tue_afternoon_open"
    t.time     "tue_afternoon_close"
    t.time     "wed_morning_open"
    t.time     "wed_morning_close"
    t.time     "wed_afternoon_open"
    t.time     "wed_afternoon_close"
    t.time     "thu_morning_open"
    t.time     "thu_morning_close"
    t.time     "thu_afternoon_open"
    t.time     "thu_afternoon_close"
    t.time     "fri_morning_open"
    t.time     "fri_morning_close"
    t.time     "fri_afternoon_open"
    t.time     "fri_afternoon_close"
    t.time     "sat_morning_open"
    t.time     "sat_morning_close"
    t.time     "sat_afternoon_open"
    t.time     "sat_afternoon_close"
    t.time     "sun_morning_open"
    t.time     "sun_morning_close"
    t.time     "sun_afternoon_open"
    t.time     "sun_afternoon_close"
  end

  add_index "timetables", ["garage_id"], name: "index_timetables_on_garage_id", using: :btree

  create_table "tyre_fees", force: true do |t|
    t.integer  "vehicle_type"
    t.integer  "diameter_min"
    t.integer  "diameter_max"
    t.integer  "rim_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.decimal  "price",        precision: 4, scale: 2
    t.integer  "garage_id"
  end

  create_table "users", force: true do |t|
    t.text     "email",                  default: "", null: false
    t.text     "encrypted_password",     default: "", null: false
    t.text     "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.text     "current_sign_in_ip"
    t.text     "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "name"
    t.text     "surname"
    t.text     "phone"
    t.text     "country"
    t.integer  "role"
    t.text     "auth_token"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
