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

ActiveRecord::Schema.define(version: 20140509204518) do

  create_table "card_purches", force: true do |t|
    t.integer  "user_id",                null: false
    t.integer  "transport_card_type_id", null: false
    t.integer  "line_id",                null: false
    t.datetime "expire_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "card_purches", ["line_id"], name: "card_purches_line_id_fk", using: :btree
  add_index "card_purches", ["transport_card_type_id"], name: "card_purches_transport_card_type_id_fk", using: :btree
  add_index "card_purches", ["user_id"], name: "card_purches_user_id_fk", using: :btree

  create_table "line_devices", force: true do |t|
    t.integer  "line_id",           null: false
    t.integer  "vehicle_device_id", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "lines", force: true do |t|
    t.string   "name",                               null: false
    t.decimal  "price",      precision: 8, scale: 2
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "transport_card_types", force: true do |t|
    t.string   "name",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.integer  "user_type_id",             default: 1, null: false
    t.string   "email",        limit: 120,             null: false
    t.string   "first_name",   limit: 120,             null: false
    t.string   "last_name",    limit: 120,             null: false
    t.string   "pin",          limit: 12,              null: false
    t.string   "password",                             null: false
    t.string   "picture"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "vehicle_devices", force: true do |t|
    t.string   "unique_id",  null: false
    t.integer  "major"
    t.integer  "minor"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_foreign_key "card_purches", "lines", name: "card_purches_line_id_fk", dependent: :delete
  add_foreign_key "card_purches", "transport_card_types", name: "card_purches_transport_card_type_id_fk", dependent: :delete
  add_foreign_key "card_purches", "users", name: "card_purches_user_id_fk", dependent: :delete

end
