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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120218140401) do

  create_table "authentications", :force => true do |t|
    t.integer  "participant_id"
    t.string   "provider"
    t.string   "uid"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  add_index "authentications", ["participant_id"], :name => "index_authentications_on_participant_id"

  create_table "clubs", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "colleges", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "days", :force => true do |t|
    t.date     "date"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "entries", :force => true do |t|
    t.string   "name"
    t.date     "birthdate"
    t.integer  "sex_id"
    t.integer  "club_id"
    t.string   "licensenumber"
    t.integer  "college_id"
    t.integer  "participant_id"
    t.string   "studentnumber"
    t.string   "banknumber"
    t.string   "bankAccountName"
    t.string   "bankLocation"
    t.boolean  "bankAuthorization"
    t.boolean  "meetRegulations"
    t.boolean  "zeusDatabase"
    t.boolean  "diner"
    t.boolean  "party"
    t.string   "shirtsize"
    t.string   "volunteerPreferences"
    t.string   "auth_hash"
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
    t.string   "study"
  end

  add_index "entries", ["club_id"], :name => "index_entries_on_club_id"
  add_index "entries", ["college_id"], :name => "index_entries_on_college_id"
  add_index "entries", ["sex_id"], :name => "index_entries_on_sex_id"

  create_table "event_participations", :force => true do |t|
    t.integer  "event_id"
    t.integer  "entry_id"
    t.float    "best_performance"
    t.date     "best_date"
    t.string   "best_location"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  add_index "event_participations", ["entry_id"], :name => "index_event_participations_on_entry_id"
  add_index "event_participations", ["event_id"], :name => "index_event_participations_on_event_id"

  create_table "events", :force => true do |t|
    t.string   "name"
    t.integer  "sex_id"
    t.boolean  "time_format"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "events", ["sex_id"], :name => "index_events_on_sex_id"

  create_table "participants", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "name",                   :default => ""
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.boolean  "admin"
  end

  add_index "participants", ["email"], :name => "index_participants_on_email", :unique => true
  add_index "participants", ["reset_password_token"], :name => "index_participants_on_reset_password_token", :unique => true

  create_table "sexes", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "volunteer_days", :force => true do |t|
    t.integer  "day_id"
    t.integer  "entry_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "volunteer_days", ["day_id"], :name => "index_volunteer_days_on_day_id"
  add_index "volunteer_days", ["entry_id"], :name => "index_volunteer_days_on_entry_id"

end
