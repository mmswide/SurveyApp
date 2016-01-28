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

ActiveRecord::Schema.define(version: 20160128160900) do

  create_table "days", force: :cascade do |t|
    t.integer  "event_id"
    t.string   "name"
    t.date     "date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "entitlements", force: :cascade do |t|
    t.integer  "ticket_id"
    t.integer  "order_id"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "description"
  end

  create_table "event_schedules", force: :cascade do |t|
    t.integer  "event_id"
    t.datetime "date"
    t.string   "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "events", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "event_name",                limit: 100
    t.text     "description_short",         limit: 300
    t.text     "description_long"
    t.string   "event_url"
    t.string   "main_image_file_name"
    t.string   "main_image_content_type"
    t.integer  "main_image_file_size"
    t.datetime "main_image_updated_at"
    t.string   "other_images_file_name"
    t.string   "other_images_content_type"
    t.integer  "other_images_file_size"
    t.datetime "other_images_updated_at"
    t.date     "start_date"
    t.date     "end_date"
    t.time     "start_time"
    t.time     "end_time"
    t.string   "venue_name"
    t.text     "venue_phone"
    t.string   "address_1"
    t.string   "addess_2"
    t.string   "city"
    t.string   "state"
    t.text     "zip_code"
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
  end

  create_table "order_transactions", force: :cascade do |t|
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.boolean  "success"
    t.string   "authorization"
    t.string   "message"
    t.string   "params"
    t.integer  "order_id"
  end

  create_table "orders", force: :cascade do |t|
    t.integer  "user_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.integer  "ticket_amount"
    t.integer  "fee"
    t.string   "buyer_first_name"
    t.string   "buyer_last_name"
    t.integer  "card_expires_year"
    t.integer  "card_expires_month"
    t.string   "card_type"
    t.string   "address1"
    t.string   "city"
    t.string   "state"
    t.integer  "zip"
    t.integer  "raw_price"
    t.integer  "total_price"
    t.string   "ip_address"
    t.integer  "event_id"
  end

  create_table "sub_events", force: :cascade do |t|
    t.integer  "day_id"
    t.datetime "hour"
    t.string   "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "tickets", force: :cascade do |t|
    t.integer  "event_id"
    t.string   "ticket_name"
    t.text     "ticket_description"
    t.decimal  "ticket_price"
    t.integer  "quantity"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  create_table "transactions", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "first_name"
    t.string   "email"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "password_digest"
    t.string   "remember_digest"
    t.boolean  "admin",               default: false
    t.string   "activation_digest"
    t.boolean  "activated",           default: false
    t.datetime "activated_at"
    t.string   "reset_digest"
    t.datetime "reset_sent_at"
    t.string   "contact_number"
    t.string   "country_of_origin"
    t.string   "current_location"
    t.string   "facebook"
    t.string   "instagram"
    t.string   "youtube"
    t.string   "last_name"
    t.string   "alias"
    t.string   "event_contact_phone"
    t.string   "event_contact_email"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true

end
