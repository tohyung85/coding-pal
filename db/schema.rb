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

ActiveRecord::Schema.define(version: 20160812152856) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "enrollments", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "group_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "enrollments", ["group_id"], name: "index_enrollments_on_group_id", using: :btree
  add_index "enrollments", ["user_id", "group_id"], name: "index_enrollments_on_user_id_and_group_id", using: :btree

  create_table "groups", force: :cascade do |t|
    t.string   "name"
    t.boolean  "remote"
    t.string   "course"
    t.integer  "commitment_hours"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.integer  "user_id"
    t.string   "image"
    t.text     "description"
    t.string   "country"
    t.string   "time_zone"
    t.integer  "row_order"
  end

  add_index "groups", ["country"], name: "index_groups_on_country", using: :btree
  add_index "groups", ["row_order"], name: "index_groups_on_row_order", using: :btree
  add_index "groups", ["time_zone"], name: "index_groups_on_time_zone", using: :btree
  add_index "groups", ["user_id"], name: "index_groups_on_user_id", using: :btree

  create_table "join_requests", force: :cascade do |t|
    t.integer  "group_id"
    t.integer  "requestor_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.text     "message"
  end

  add_index "join_requests", ["group_id"], name: "index_join_requests_on_group_id", using: :btree
  add_index "join_requests", ["requestor_id", "group_id"], name: "index_join_requests_on_requestor_id_and_group_id", using: :btree

  create_table "messages", force: :cascade do |t|
    t.string   "message_title"
    t.text     "message_description"
    t.integer  "user_id"
    t.integer  "group_id"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

  add_index "messages", ["group_id", "user_id"], name: "index_messages_on_group_id_and_user_id", using: :btree
  add_index "messages", ["user_id"], name: "index_messages_on_user_id", using: :btree

  create_table "profiles", force: :cascade do |t|
    t.string   "user_name",   default: "my username"
    t.boolean  "remote_ok?",  default: true
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.integer  "user_id"
    t.string   "avatar"
    t.text     "description"
    t.string   "country"
    t.string   "time_zone"
  end

  add_index "profiles", ["country"], name: "index_profiles_on_country", using: :btree
  add_index "profiles", ["time_zone"], name: "index_profiles_on_time_zone", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
