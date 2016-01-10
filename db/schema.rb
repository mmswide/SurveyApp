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

ActiveRecord::Schema.define(version: 20160109015927) do

  create_table "events", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "event_name",        limit: 100
    t.text     "description_short", limit: 300
    t.text     "description_long"
    t.string   "profile image_url"
    t.text     "other_images_url"
    t.string   "contact_name"
    t.text     "contact_phone"
    t.string   "contact_email"
    t.string   "venue_name"
    t.text     "venue_phone"
    t.string   "address_1"
    t.string   "addess_2"
    t.string   "city"
    t.string   "state"
    t.text     "zip_code"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  create_table "tickets", force: :cascade do |t|
    t.integer  "event_id"
    t.string   "ticket_name"
    t.text     "ticket_decription"
    t.integer  "ticket_price"
    t.integer  "quantity"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.string   "password_digest"
    t.string   "remember_digest"
    t.boolean  "admin",             default: false
    t.string   "activation_digest"
    t.boolean  "activated",         default: false
    t.datetime "activated_at"
    t.string   "reset_digest"
    t.datetime "reset_sent_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true

end
