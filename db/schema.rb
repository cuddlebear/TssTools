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
    t.integer  "filter_type_property_id"
    t.integer  "interval_property_id"
    t.integer  "sort_order"
    t.datetime "created_at",              :null => false
    t.datetime "updated_at",              :null => false
  end

  add_index "areas", ["domain_id"], :name => "index_areas_on_domain_id"
  add_index "areas", ["filter_type_property_id"], :name => "index_areas_on_filter_type_property_id"
  add_index "areas", ["interval_property_id"], :name => "index_areas_on_interval_property_id"
  add_index "areas", ["sort_order"], :name => "index_areas_on_sort_order"

  create_table "checks", :force => true do |t|
    t.integer  "page_id"
    t.integer  "priority"
    t.integer  "type"
    t.integer  "result_code"
    t.string   "result_text"
    t.datetime "scheduled_start"
    t.datetime "check_start"
    t.integer  "duration"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  add_index "checks", ["page_id"], :name => "index_checks_on_page_id"

  create_table "domains", :force => true do |t|
    t.integer  "account_id"
    t.boolean  "active"
    t.string   "name"
    t.text     "description"
    t.string   "scheme"
    t.string   "domain"
    t.string   "port"
    t.boolean  "check_page_rank"
    t.boolean  "check_page_speed"
    t.boolean  "check_y_slow"
    t.boolean  "check_content_for_changes"
    t.string   "main_container"
    t.string   "navigation_container"
    t.string   "subnavigation_container"
    t.string   "ignore_container"
    t.boolean  "check_publish_time"
    t.string   "regx_publish_time"
    t.integer  "sort_order"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  add_index "domains", ["account_id"], :name => "index_domains_on_account_id"
  add_index "domains", ["domain"], :name => "index_domains_on_domain"
  add_index "domains", ["name"], :name => "index_domains_on_name"
  add_index "domains", ["sort_order"], :name => "index_domains_on_sort_order"

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
    t.integer  "area_id"
    t.boolean  "active"
    t.string   "path"
    t.string   "title"
    t.integer  "status"
    t.integer  "page_rank"
    t.integer  "page_speed"
    t.integer  "y_slow"
    t.integer  "check_counter"
    t.datetime "last_change"
    t.datetime "last_check"
    t.boolean  "area_is_dirty"
    t.string   "actual_content"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  add_index "pages", ["area_id"], :name => "index_pages_on_area_id"
  add_index "pages", ["domain_id"], :name => "index_pages_on_domain_id"
  add_index "pages", ["last_change"], :name => "index_pages_on_last_change"
  add_index "pages", ["last_check"], :name => "index_pages_on_last_check"
  add_index "pages", ["path"], :name => "index_pages_on_path"
  add_index "pages", ["status"], :name => "index_pages_on_status"

  create_table "properties", :force => true do |t|
    t.integer  "property_group_id"
    t.string   "name"
    t.integer  "value"
    t.integer  "sort_order"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  add_index "properties", ["property_group_id"], :name => "index_properties_on_property_group_id"
  add_index "properties", ["sort_order"], :name => "index_properties_on_sort_order"

  create_table "property_groups", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.boolean  "active"
    t.integer  "sort_order"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "property_groups", ["sort_order"], :name => "index_property_groups_on_sort_order"

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
    t.boolean  "account_admin"
    t.boolean  "super_admin"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  add_index "users", ["account_id"], :name => "index_users_on_account_id"
  add_index "users", ["email"], :name => "index_users_on_email"
  add_index "users", ["username"], :name => "index_users_on_username"

  add_foreign_key "checks", "pages", :name => "checks_page_id_fk"

  add_foreign_key "domains", "accounts", :name => "domains_account_id_fk"

  add_foreign_key "page_properties", "pages", :name => "page_properties_page_id_fk"
  add_foreign_key "page_properties", "properties", :name => "page_properties_property_id_fk"

  add_foreign_key "pages", "areas", :name => "pages_area_id_fk"
  add_foreign_key "pages", "domains", :name => "pages_domain_id_fk"

  add_foreign_key "properties", "property_groups", :name => "properties_property_group_id_fk"

  add_foreign_key "users", "accounts", :name => "users_account_id_fk"

end
