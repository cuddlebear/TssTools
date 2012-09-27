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

ActiveRecord::Schema.define(:version => 20120927104048) do

  create_table "accounts", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.boolean  "active"
    t.boolean  "locked"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "accounts", ["name"], :name => "index_accounts_on_name"

  create_table "areas", :force => true do |t|
    t.integer  "domain_id"
    t.string   "name"
    t.string   "filter"
    t.integer  "filterType"
    t.integer  "property_id"
    t.integer  "sortOrder"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "areas", ["domain_id"], :name => "index_areas_on_domain_id"
  add_index "areas", ["property_id"], :name => "index_areas_on_property_id"
  add_index "areas", ["sortOrder"], :name => "index_areas_on_sortOrder"

  create_table "checks", :force => true do |t|
    t.integer  "page_id"
    t.integer  "priority"
    t.integer  "type"
    t.integer  "resultCode"
    t.string   "resultText"
    t.datetime "scheduledStart"
    t.datetime "checkStart"
    t.integer  "duration"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  add_index "checks", ["page_id"], :name => "checks_page_id_fk"

  create_table "domains", :force => true do |t|
    t.integer  "account_id"
    t.string   "name"
    t.text     "description"
    t.string   "scheme"
    t.string   "domain"
    t.string   "port"
    t.boolean  "checkPageRank"
    t.boolean  "checkPageSpeed"
    t.boolean  "checkYSlow"
    t.boolean  "checkContentForChanges"
    t.string   "mainContainer"
    t.string   "navigationContainer"
    t.string   "subnavigationContainer"
    t.string   "ignoreContainer"
    t.boolean  "checkPublishTime"
    t.string   "regxPublishTime"
    t.boolean  "active"
    t.integer  "sortorder"
    t.datetime "created_at",             :null => false
    t.datetime "updated_at",             :null => false
  end

  add_index "domains", ["account_id"], :name => "index_domains_on_account_id"
  add_index "domains", ["domain"], :name => "index_domains_on_domain"
  add_index "domains", ["name"], :name => "index_domains_on_name"
  add_index "domains", ["sortorder"], :name => "index_domains_on_sortorder"

  create_table "page_properties", :force => true do |t|
    t.integer  "page_id"
    t.integer  "property_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "page_properties", ["page_id"], :name => "index_page_properties_on_page_id"
  add_index "page_properties", ["property_id"], :name => "index_page_properties_on_property_id"

  create_table "pages", :force => true do |t|
    t.integer  "domain_id"
    t.string   "path"
    t.string   "title"
    t.boolean  "active"
    t.integer  "status"
    t.integer  "pageRank"
    t.integer  "pageSpeed"
    t.integer  "ySlow"
    t.integer  "checkCounter"
    t.datetime "lastChange"
    t.datetime "lastCheck"
    t.string   "actContent"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "pages", ["domain_id"], :name => "index_pages_on_domain_id"
  add_index "pages", ["lastChange"], :name => "index_pages_on_lastChange"
  add_index "pages", ["lastCheck"], :name => "index_pages_on_lastCheck"
  add_index "pages", ["path"], :name => "index_pages_on_path"
  add_index "pages", ["status"], :name => "index_pages_on_status"

  create_table "properties", :force => true do |t|
    t.integer  "property_group_id"
    t.string   "name"
    t.integer  "value"
    t.integer  "sortorder"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  add_index "properties", ["property_group_id"], :name => "index_properties_on_property_group_id"
  add_index "properties", ["sortorder"], :name => "index_properties_on_sortorder"

  create_table "property_groups", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.boolean  "active"
    t.integer  "sortorder"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "property_groups", ["sortorder"], :name => "index_property_groups_on_sortorder"

  create_table "users", :force => true do |t|
    t.integer  "account_id"
    t.string   "username"
    t.string   "email"
    t.string   "phone"
    t.string   "firstName"
    t.string   "lastName"
    t.string   "company"
    t.string   "address1"
    t.string   "address2"
    t.string   "address3"
    t.string   "zip"
    t.string   "city"
    t.string   "country"
    t.string   "state"
    t.string   "crypted_password"
    t.string   "password_salt"
    t.string   "persistence_token"
    t.boolean  "active"
    t.boolean  "locked"
    t.boolean  "accountAdmin"
    t.boolean  "superAdmin"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  add_index "users", ["account_id"], :name => "index_users_on_account_id"
  add_index "users", ["email"], :name => "index_users_on_email"
  add_index "users", ["username"], :name => "index_users_on_username"

  add_foreign_key "areas", "domains", :name => "areas_domain_id_fk"
  add_foreign_key "areas", "properties", :name => "areas_property_id_fk"

  add_foreign_key "checks", "pages", :name => "checks_page_id_fk"

  add_foreign_key "domains", "accounts", :name => "domains_account_id_fk"

  add_foreign_key "page_properties", "pages", :name => "page_properties_page_id_fk"
  add_foreign_key "page_properties", "properties", :name => "page_properties_property_id_fk"

  add_foreign_key "pages", "domains", :name => "pages_domain_id_fk"

  add_foreign_key "properties", "property_groups", :name => "properties_property_group_id_fk"

  add_foreign_key "users", "accounts", :name => "users_account_id_fk"

end
