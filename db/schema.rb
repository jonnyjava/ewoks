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

ActiveRecord::Schema.define(version: 20160606212011) do

  create_table "demands", force: :cascade do |t|
    t.string   "city",                limit: 255
    t.integer  "service_category_id", limit: 4
    t.integer  "service_id",          limit: 4
    t.string   "vin_number",          limit: 255
    t.string   "brand",               limit: 255
    t.string   "model",               limit: 255
    t.string   "year",                limit: 255
    t.string   "engine",              limit: 255
    t.string   "engine_letters",      limit: 255
    t.string   "name_and_surnames",   limit: 255
    t.string   "phone",               limit: 255
    t.string   "email",               limit: 255
    t.boolean  "wants_newsletter",    limit: 1
    t.boolean  "accepts_privacy",     limit: 1
    t.text     "comments",            limit: 65535
    t.text     "demand_details",      limit: 65535
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
  end

  add_index "demands", ["service_category_id"], name: "index_demands_on_service_category_id", using: :btree
  add_index "demands", ["service_id"], name: "index_demands_on_service_id", using: :btree

  create_table "demands_garages", force: :cascade do |t|
    t.integer "garage_id",         limit: 4, null: false
    t.integer "demand_id",         limit: 4, null: false
    t.integer "quote_proposal_id", limit: 4
  end

  add_index "demands_garages", ["demand_id", "garage_id"], name: "index_demands_garages_on_demand_id_and_garage_id", using: :btree
  add_index "demands_garages", ["garage_id", "demand_id"], name: "index_demands_garages_on_garage_id_and_demand_id", using: :btree
  add_index "demands_garages", ["quote_proposal_id"], name: "index_demands_garages_on_quote_proposal_id", using: :btree

  create_table "garage_recruitables", force: :cascade do |t|
    t.string   "name",              limit: 255
    t.string   "street",            limit: 255
    t.string   "zip",               limit: 255
    t.string   "city",              limit: 255
    t.string   "email",             limit: 255
    t.string   "phone",             limit: 255
    t.string   "mobile",            limit: 255
    t.string   "tax_id",            limit: 255
    t.string   "province",          limit: 255
    t.integer  "status",            limit: 4,     default: 0
    t.datetime "created_at",                                  null: false
    t.datetime "updated_at",                                  null: false
    t.string   "token",             limit: 255
    t.string   "scrapped_id",       limit: 255
    t.string   "scrapped_type",     limit: 255
    t.string   "address",           limit: 255
    t.string   "fax",               limit: 255
    t.string   "fees",              limit: 255
    t.string   "owner",             limit: 255
    t.string   "timetable",         limit: 255
    t.string   "website",           limit: 255
    t.string   "zipcode_with_city", limit: 255
    t.text     "service_list",      limit: 65535
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
    t.integer  "owner_id",          limit: 4
    t.string   "logo_file_name",    limit: 255
    t.string   "logo_content_type", limit: 255
    t.integer  "logo_file_size",    limit: 4
    t.datetime "logo_updated_at"
    t.integer  "status",            limit: 4,                           default: -1
    t.string   "province",          limit: 255
  end

  create_table "garages_services", id: false, force: :cascade do |t|
    t.integer "garage_id",  limit: 4, null: false
    t.integer "service_id", limit: 4, null: false
  end

  add_index "garages_services", ["garage_id", "service_id"], name: "index_garages_services_on_garage_id_and_service_id", using: :btree
  add_index "garages_services", ["service_id", "garage_id"], name: "index_garages_services_on_service_id_and_garage_id", using: :btree

  create_table "holidays", force: :cascade do |t|
    t.date     "start_date"
    t.date     "end_date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "garage_id",  limit: 4
    t.string   "name",       limit: 255
  end

  add_index "holidays", ["garage_id"], name: "index_holidays_on_garage_id", using: :btree

  create_table "quote_proposals", force: :cascade do |t|
    t.integer  "garage_id",          limit: 4
    t.integer  "demand_id",          limit: 4
    t.text     "proposal",           limit: 65535
    t.decimal  "ttc_price",                        precision: 8, scale: 2
    t.date     "expiration"
    t.integer  "status",             limit: 4,                             default: 0
    t.datetime "created_at",                                                           null: false
    t.datetime "updated_at",                                                           null: false
    t.integer  "demands_garage_id",  limit: 4
    t.string   "doc1_file_name",     limit: 255
    t.string   "doc1_content_type",  limit: 255
    t.integer  "doc1_file_size",     limit: 4
    t.datetime "doc1_updated_at"
    t.string   "doc2_file_name",     limit: 255
    t.string   "doc2_content_type",  limit: 255
    t.integer  "doc2_file_size",     limit: 4
    t.datetime "doc2_updated_at"
    t.string   "doc3_file_name",     limit: 255
    t.string   "doc3_content_type",  limit: 255
    t.integer  "doc3_file_size",     limit: 4
    t.datetime "doc3_updated_at"
    t.integer  "deliverable_status", limit: 4,                             default: 0
    t.string   "mail_token",         limit: 255
  end

  add_index "quote_proposals", ["demand_id"], name: "index_quote_proposals_on_demand_id", using: :btree
  add_index "quote_proposals", ["demands_garage_id"], name: "index_quote_proposals_on_demands_garage_id", using: :btree
  add_index "quote_proposals", ["garage_id"], name: "index_quote_proposals_on_garage_id", using: :btree
  add_index "quote_proposals", ["mail_token"], name: "index_quote_proposals_on_mail_token", using: :btree

  create_table "service_categories", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.string   "icon",       limit: 255
  end

  create_table "service_definitions", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.integer  "service_id", limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "service_definitions", ["service_id"], name: "index_service_definitions_on_service_id", using: :btree

  create_table "services", force: :cascade do |t|
    t.string   "name",                limit: 255
    t.integer  "service_category_id", limit: 4
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
  end

  add_index "services", ["service_category_id"], name: "index_services_on_service_category_id", using: :btree

  create_table "timetables", force: :cascade do |t|
    t.integer  "garage_id",           limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "mon_morning_open",    limit: 255
    t.string   "mon_morning_close",   limit: 255
    t.string   "mon_afternoon_open",  limit: 255
    t.string   "mon_afternoon_close", limit: 255
    t.string   "tue_morning_open",    limit: 255
    t.string   "tue_morning_close",   limit: 255
    t.string   "tue_afternoon_open",  limit: 255
    t.string   "tue_afternoon_close", limit: 255
    t.string   "wed_morning_open",    limit: 255
    t.string   "wed_morning_close",   limit: 255
    t.string   "wed_afternoon_open",  limit: 255
    t.string   "wed_afternoon_close", limit: 255
    t.string   "thu_morning_open",    limit: 255
    t.string   "thu_morning_close",   limit: 255
    t.string   "thu_afternoon_open",  limit: 255
    t.string   "thu_afternoon_close", limit: 255
    t.string   "fri_morning_open",    limit: 255
    t.string   "fri_morning_close",   limit: 255
    t.string   "fri_afternoon_open",  limit: 255
    t.string   "fri_afternoon_close", limit: 255
    t.string   "sat_morning_open",    limit: 255
    t.string   "sat_morning_close",   limit: 255
    t.string   "sat_afternoon_open",  limit: 255
    t.string   "sat_afternoon_close", limit: 255
    t.string   "sun_morning_open",    limit: 255
    t.string   "sun_morning_close",   limit: 255
    t.string   "sun_afternoon_open",  limit: 255
    t.string   "sun_afternoon_close", limit: 255
  end

  add_index "timetables", ["garage_id"], name: "index_timetables_on_garage_id", using: :btree

  create_table "tyre_fees", force: :cascade do |t|
    t.integer  "vehicle_type", limit: 4
    t.integer  "diameter_min", limit: 4
    t.integer  "diameter_max", limit: 4
    t.integer  "rim_type",     limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name",         limit: 255
    t.decimal  "price",                    precision: 15, scale: 2
    t.integer  "garage_id",    limit: 4
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,  null: false
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
    t.integer  "role",                   limit: 4
    t.string   "auth_token",             limit: 255
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "demands", "service_categories"
  add_foreign_key "demands", "services"
  add_foreign_key "quote_proposals", "demands"
  add_foreign_key "quote_proposals", "demands_garages"
  add_foreign_key "quote_proposals", "garages"
  add_foreign_key "service_definitions", "services"
  add_foreign_key "services", "service_categories"
end
