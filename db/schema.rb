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

ActiveRecord::Schema.define(:version => 20120216121400) do

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

  create_table "event_participations", :force => true do |t|
    t.integer  "event_id"
    t.integer  "registration_id"
    t.string   "best_performance"
    t.date     "best_date"
    t.string   "best_location"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  add_index "event_participations", ["event_id"], :name => "index_event_participations_on_event_id"
  add_index "event_participations", ["registration_id"], :name => "index_event_participations_on_registration_id"

  create_table "events", :force => true do |t|
    t.string   "name"
    t.integer  "sex_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
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
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "participants", ["email"], :name => "index_participants_on_email", :unique => true
  add_index "participants", ["reset_password_token"], :name => "index_participants_on_reset_password_token", :unique => true

  create_table "registrations", :force => true do |t|
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
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
    t.string   "study"
  end

  add_index "registrations", ["club_id"], :name => "index_registrations_on_club_id"
  add_index "registrations", ["college_id"], :name => "index_registrations_on_college_id"
  add_index "registrations", ["sex_id"], :name => "index_registrations_on_sex_id"

  create_table "roles", :force => true do |t|
    t.string   "name",              :limit => 40
    t.string   "authorizable_type", :limit => 40
    t.integer  "authorizable_id"
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
  end

  create_table "roles_registrations", :id => false, :force => true do |t|
    t.integer  "registration_id"
    t.integer  "role_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "sexes", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "user_sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "user_sessions", ["session_id"], :name => "index_user_sessions_on_session_id"
  add_index "user_sessions", ["updated_at"], :name => "index_user_sessions_on_updated_at"

  create_table "volunteer_days", :force => true do |t|
    t.integer  "day_id"
    t.integer  "registration_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  add_index "volunteer_days", ["day_id"], :name => "index_volunteer_days_on_day_id"
  add_index "volunteer_days", ["registration_id"], :name => "index_volunteer_days_on_registration_id"

end
