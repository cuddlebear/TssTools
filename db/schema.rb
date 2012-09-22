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

ActiveRecord::Schema.define(:version => 20120922130444) do

  create_table "checks", :force => true do |t|
    t.integer  "url_id"
    t.integer  "priority"
    t.integer  "type"
    t.integer  "resultCode"
    t.string   "resultText"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "checks", ["url_id"], :name => "index_checks_on_url_id"

  create_table "domains", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.string   "url"
    t.integer  "sortorder"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "domains", ["name"], :name => "index_domains_on_name"
  add_index "domains", ["sortorder"], :name => "index_domains_on_sortorder"

  create_table "properties", :force => true do |t|
    t.string   "value"
    t.integer  "property_group_id"
    t.integer  "sortorder"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  add_index "properties", ["sortorder"], :name => "index_properties_on_sortorder"

  create_table "property_groups", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "sortorder"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "property_groups", ["sortorder"], :name => "index_property_groups_on_sortorder"

  create_table "url_properties", :force => true do |t|
    t.integer  "url_id"
    t.integer  "property_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "url_properties", ["property_id"], :name => "index_url_properties_on_property_id"
  add_index "url_properties", ["url_id"], :name => "index_url_properties_on_url_id"

  create_table "urls", :force => true do |t|
    t.string   "path"
    t.integer  "domain_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "urls", ["domain_id"], :name => "index_urls_on_domain_id"
  add_index "urls", ["path"], :name => "index_urls_on_path"

end
