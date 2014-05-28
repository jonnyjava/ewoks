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

ActiveRecord::Schema.define(version: 20140528163943) do

  create_table "fees", force: true do |t|
    t.string   "name"
    t.decimal  "price"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "garage_id"
  end

  add_index "fees", ["garage_id"], name: "index_fees_on_garage_id"

  create_table "garages", force: true do |t|
    t.string   "name"
    t.string   "owner"
    t.string   "addres"
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
  end

  create_table "garages_properties", id: false, force: true do |t|
    t.integer "garage_id",   null: false
    t.integer "property_id", null: false
  end

  add_index "garages_properties", ["garage_id", "property_id"], name: "index_garages_properties_on_garage_id_and_property_id"
  add_index "garages_properties", ["property_id", "garage_id"], name: "index_garages_properties_on_property_id_and_garage_id"

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
    t.string   "type"
    t.string   "value"
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

end
