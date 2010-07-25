# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20100724133128) do

  create_table "feeds", :force => true do |t|
    t.string   "type"
    t.string   "name"
    t.string   "shortname"
    t.string   "feed_type"
    t.integer  "site_id"
    t.string   "url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "shots", :force => true do |t|
    t.integer  "feed_id"
    t.string   "url"
    t.string   "img"
    t.integer  "width"
    t.integer  "height"
    t.string   "title"
    t.datetime "pubdate"
    t.string   "author"
    t.string   "location"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "shots", ["feed_id"], :name => "feed_id_ix"
  add_index "shots", ["url"], :name => "url_ix"

  create_table "sites", :force => true do |t|
    t.string   "name"
    t.string   "shortname"
    t.string   "url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
