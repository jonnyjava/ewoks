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

ActiveRecord::Schema.define(version: 20160314112535) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "garage_recruitables", force: :cascade do |t|
    t.string   "name"
    t.string   "street"
    t.string   "zip"
    t.string   "city"
    t.string   "email"
    t.string   "phone"
    t.string   "mobile"
    t.string   "tax_id"
    t.string   "province"
    t.integer  "status",     default: 0
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.string   "token"
  end

  create_table "garages", force: :cascade do |t|
    t.string   "name",              limit: 255
    t.string   "street",            limit: 255
    t.string   "zip",               limit: 255
    t.string   "city",              limit: 255
    t.string   "email",             limit: 255
    t.string   "phone",             limit: 255
    t.string   "mobile",            limit: 255
    t.string   "fax",               limit: 255
    t.decimal  "latitude",                      precision: 9, scale: 6
    t.decimal  "longitude",                     precision: 9, scale: 6
    t.string   "tax_id",            limit: 255
    t.string   "website",           limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "country",           limit: 255
    t.integer  "owner_id"
    t.string   "logo_file_name",    limit: 255
    t.string   "logo_content_type", limit: 255
    t.integer  "logo_file_size"
    t.datetime "logo_updated_at"
    t.integer  "status",                                                default: -1
    t.string   "province",          limit: 255
    t.string   "service_ids"
  end

  create_table "holidays", force: :cascade do |t|
    t.date     "start_date"
    t.date     "end_date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "garage_id"
    t.string   "name",       limit: 255
  end

  add_index "holidays", ["garage_id"], name: "index_holidays_on_garage_id", using: :btree

  create_table "timetables", force: :cascade do |t|
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

  create_table "tyre_fees", force: :cascade do |t|
    t.integer  "vehicle_type"
    t.integer  "diameter_min"
    t.integer  "diameter_max"
    t.integer  "rim_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name",         limit: 255
    t.decimal  "price",                    precision: 15, scale: 2
    t.integer  "garage_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                      default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name",                   limit: 255
    t.string   "surname",                limit: 255
    t.string   "phone",                  limit: 255
    t.string   "country",                limit: 255
    t.integer  "role"
    t.string   "auth_token",             limit: 255
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
