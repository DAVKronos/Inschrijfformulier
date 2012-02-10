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

ActiveRecord::Schema.define(:version => 20120210193233) do

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
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
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

  create_table "registrations", :force => true do |t|
    t.string   "name"
    t.string   "birthdate"
    t.integer  "sex_id"
    t.integer  "club_id"
    t.string   "licensenumber"
    t.integer  "college_id"
    t.string   "studentnumber"
    t.string   "email"
    t.string   "banknumber"
    t.string   "bankAccountName"
    t.string   "bankLocation"
    t.boolean  "bankAuthorization"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
    t.string   "study"
  end

  add_index "registrations", ["club_id"], :name => "index_registrations_on_club_id"
  add_index "registrations", ["college_id"], :name => "index_registrations_on_college_id"
  add_index "registrations", ["sex_id"], :name => "index_registrations_on_sex_id"

  create_table "sexes", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "volunteer_days", :force => true do |t|
    t.integer  "day_id"
    t.integer  "registration_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  add_index "volunteer_days", ["day_id"], :name => "index_volunteer_days_on_day_id"
  add_index "volunteer_days", ["registration_id"], :name => "index_volunteer_days_on_registration_id"

end
