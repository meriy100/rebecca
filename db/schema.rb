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

ActiveRecord::Schema.define(version: 20160709144851) do

  create_table "events", force: :cascade do |t|
    t.integer  "user_id",            limit: 4
    t.integer  "google_calendar_id", limit: 4
    t.string   "summary",            limit: 255
    t.string   "sync_token",         limit: 255
    t.datetime "date"
    t.string   "description",        limit: 255
    t.integer  "status",             limit: 4,   default: 1
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
  end

  add_index "events", ["google_calendar_id"], name: "index_events_on_google_calendar_id", using: :btree
  add_index "events", ["user_id"], name: "index_events_on_user_id", using: :btree

  create_table "google_accounts", force: :cascade do |t|
    t.integer  "user_id",       limit: 4
    t.string   "email",         limit: 255
    t.string   "access_token",  limit: 255
    t.string   "refresh_token", limit: 255
    t.integer  "expires_in",    limit: 4
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "google_accounts", ["user_id"], name: "index_google_accounts_on_user_id", using: :btree

  create_table "google_calendars", force: :cascade do |t|
    t.integer  "user_id",           limit: 4
    t.integer  "google_account_id", limit: 4
    t.string   "calendar_id",       limit: 255
    t.string   "summary",           limit: 255
    t.integer  "status",            limit: 4
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  add_index "google_calendars", ["google_account_id"], name: "index_google_calendars_on_google_account_id", using: :btree
  add_index "google_calendars", ["user_id"], name: "index_google_calendars_on_user_id", using: :btree

  create_table "settings", force: :cascade do |t|
    t.integer  "user_id",           limit: 4,             null: false
    t.integer  "start_week_day_id", limit: 4, default: 1
    t.integer  "time_format_id",    limit: 4, default: 1
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
  end

  create_table "tasks", force: :cascade do |t|
    t.integer  "user_id",     limit: 4
    t.string   "title",       limit: 255
    t.boolean  "is_done"
    t.string   "sync_token",  limit: 255
    t.float    "weight",      limit: 24
    t.datetime "deadline_at"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.integer  "event_id",    limit: 4
  end

  add_index "tasks", ["event_id"], name: "index_tasks_on_event_id", using: :btree
  add_index "tasks", ["sync_token"], name: "index_tasks_on_sync_token", unique: true, using: :btree
  add_index "tasks", ["user_id"], name: "index_tasks_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "name",            limit: 255
    t.string   "password_digest", limit: 255
    t.string   "email",           limit: 255
    t.datetime "deleted_at"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

end
