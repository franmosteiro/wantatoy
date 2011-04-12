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

ActiveRecord::Schema.define(:version => 20110411213938) do

  create_table "contacts", :force => true do |t|
    t.string   "email"
    t.integer  "toy_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "toys", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.string   "contact"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "thumb_file_name"
    t.string   "thumb_content_type"
    t.integer  "thumb_file_size"
    t.datetime "thumb_updated_at"
    t.string   "activation_token"
    t.string   "cancelation_token"
    t.string   "permalink"
    t.float    "lat"
    t.float    "lng"
    t.string   "location"
  end

end
