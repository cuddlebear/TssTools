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

ActiveRecord::Schema.define(:version => 20121117105725) do

  create_table "accounts", :force => true do |t|
    t.string   "uuid",        :null => false
    t.string   "name"
    t.string   "description"
    t.boolean  "active"
    t.boolean  "locked"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "accounts", ["name"], :name => "index_accounts_on_name"
  add_index "accounts", ["uuid"], :name => "index_accounts_on_uuid", :unique => true

  create_table "areas", :force => true do |t|
    t.string   "uuid",                      :null => false
    t.integer  "domain_id"
    t.integer  "filter_type_property_id"
    t.integer  "interval_property_id"
    t.integer  "language_code_property_id"
    t.string   "name"
    t.string   "filter"
    t.boolean  "screen_shot"
    t.integer  "max_screen_shots_per_page"
    t.integer  "row_order"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  add_index "areas", ["domain_id"], :name => "index_areas_on_domain_id"
  add_index "areas", ["filter_type_property_id"], :name => "index_areas_on_filter_type_property_id"
  add_index "areas", ["interval_property_id"], :name => "index_areas_on_interval_property_id"
  add_index "areas", ["language_code_property_id"], :name => "index_areas_on_language_code_property_id"
  add_index "areas", ["row_order"], :name => "index_areas_on_row_order"
  add_index "areas", ["uuid"], :name => "index_areas_on_uuid", :unique => true

  create_table "checks", :force => true do |t|
    t.string   "uuid",            :null => false
    t.integer  "domain_id"
    t.integer  "page_id"
    t.integer  "priority"
    t.integer  "type"
    t.integer  "result_code"
    t.string   "result_text"
    t.datetime "scheduled_start"
    t.boolean  "in_process"
    t.datetime "check_start"
    t.integer  "duration"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  add_index "checks", ["check_start"], :name => "index_checks_on_check_start"
  add_index "checks", ["domain_id"], :name => "index_checks_on_domain_id"
  add_index "checks", ["page_id"], :name => "index_checks_on_page_id"
  add_index "checks", ["scheduled_start"], :name => "index_checks_on_scheduled_start"
  add_index "checks", ["uuid"], :name => "index_checks_on_uuid", :unique => true

  create_table "containers", :force => true do |t|
    t.string   "uuid",                     :null => false
    t.integer  "container_id"
    t.integer  "domain_id"
    t.integer  "content_type_property_id"
    t.string   "name"
    t.string   "x_path"
    t.boolean  "ignore"
    t.integer  "row_order"
    t.datetime "created_at",               :null => false
    t.datetime "updated_at",               :null => false
  end

  add_index "containers", ["container_id"], :name => "index_containers_on_container_id"
  add_index "containers", ["content_type_property_id"], :name => "index_containers_on_content_type_property_id"
  add_index "containers", ["domain_id"], :name => "index_containers_on_domain_id"
  add_index "containers", ["uuid"], :name => "index_containers_on_uuid", :unique => true

  create_table "contents", :force => true do |t|
    t.integer  "container_id"
    t.string   "md5_hash"
    t.text     "text"
    t.integer  "language_property_id"
    t.integer  "links_internal"
    t.integer  "links_internal_broken"
    t.integer  "links_external"
    t.integer  "links_external_broken"
    t.integer  "links_file"
    t.integer  "links_file_broken"
    t.integer  "headlines"
    t.integer  "paragraphs"
    t.integer  "words"
    t.integer  "characters"
    t.integer  "images"
    t.datetime "created_at",            :null => false
    t.datetime "updated_at",            :null => false
  end

  add_index "contents", ["container_id"], :name => "index_contents_on_container_id"
  add_index "contents", ["language_property_id"], :name => "index_contents_on_language_property_id"
  add_index "contents", ["md5_hash"], :name => "index_contents_on_md5_hash"

  create_table "domains", :force => true do |t|
    t.string   "uuid",                      :null => false
    t.integer  "account_id"
    t.boolean  "active"
    t.string   "name"
    t.text     "description"
    t.string   "scheme"
    t.string   "domain"
    t.string   "port"
    t.integer  "status"
    t.boolean  "check_page_rank"
    t.boolean  "check_page_speed"
    t.boolean  "check_y_slow"
    t.boolean  "check_content_for_changes"
    t.boolean  "check_publish_time"
    t.boolean  "screen_shot"
    t.integer  "max_screen_shots_per_page"
    t.string   "regx_publish_time"
    t.integer  "row_order"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  add_index "domains", ["account_id"], :name => "index_domains_on_account_id"
  add_index "domains", ["domain"], :name => "index_domains_on_domain"
  add_index "domains", ["name"], :name => "index_domains_on_name"
  add_index "domains", ["row_order"], :name => "index_domains_on_row_order"
  add_index "domains", ["uuid"], :name => "index_domains_on_uuid", :unique => true

  create_table "links", :force => true do |t|
    t.integer  "content_id"
    t.integer  "page_id"
    t.datetime "from"
    t.datetime "until"
  end

  add_index "links", ["content_id"], :name => "index_links_on_content_id"
  add_index "links", ["from"], :name => "index_links_on_from"
  add_index "links", ["page_id"], :name => "index_links_on_page_id"
  add_index "links", ["until"], :name => "index_links_on_until"

  create_table "page_contents", :force => true do |t|
    t.integer  "page_id"
    t.integer  "content_id"
    t.datetime "from"
    t.datetime "until"
  end

  add_index "page_contents", ["content_id"], :name => "index_page_contents_on_content_id"
  add_index "page_contents", ["from"], :name => "index_page_contents_on_from"
  add_index "page_contents", ["page_id", "content_id"], :name => "index_page_contents_on_page_id_and_content_id"
  add_index "page_contents", ["page_id"], :name => "index_page_contents_on_page_id"
  add_index "page_contents", ["until"], :name => "index_page_contents_on_until"

  create_table "page_properties", :force => true do |t|
    t.integer  "page_id"
    t.integer  "property_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "page_properties", ["page_id"], :name => "index_page_properties_on_page_id"
  add_index "page_properties", ["property_id"], :name => "index_page_properties_on_property_id"

  create_table "pages", :force => true do |t|
    t.string   "uuid",                               :null => false
    t.integer  "domain_id"
    t.integer  "area_id"
    t.integer  "path_id"
    t.boolean  "active"
    t.integer  "level"
    t.string   "file_name"
    t.string   "parameter"
    t.string   "title"
    t.integer  "status"
    t.boolean  "check_for_content"
    t.string   "content_to_check_for_existence"
    t.string   "content_to_check_for_not_existence"
    t.integer  "page_rank"
    t.integer  "page_speed"
    t.integer  "y_slow"
    t.integer  "check_counter"
    t.datetime "last_change"
    t.datetime "last_check"
    t.datetime "last_publish"
    t.datetime "from"
    t.datetime "until"
    t.boolean  "area_is_dirty"
    t.boolean  "screen_shot"
    t.integer  "max_screen_shots_per_page"
    t.string   "actual_content"
  end

  add_index "pages", ["area_id"], :name => "index_pages_on_area_id"
  add_index "pages", ["domain_id", "path_id", "file_name"], :name => "index_pages_on_domain_id_and_path_id_and_file_name"
  add_index "pages", ["from"], :name => "index_pages_on_from"
  add_index "pages", ["last_change"], :name => "index_pages_on_last_change"
  add_index "pages", ["last_check"], :name => "index_pages_on_last_check"
  add_index "pages", ["last_publish"], :name => "index_pages_on_last_publish"
  add_index "pages", ["level"], :name => "index_pages_on_level"
  add_index "pages", ["path_id"], :name => "pages_path_id_fk"
  add_index "pages", ["status"], :name => "index_pages_on_status"
  add_index "pages", ["until"], :name => "index_pages_on_until"
  add_index "pages", ["uuid"], :name => "index_pages_on_uuid", :unique => true

  create_table "paths", :force => true do |t|
    t.string   "uuid",           :null => false
    t.integer  "domain_id"
    t.integer  "path_id"
    t.string   "ancestry"
    t.integer  "ancestry_depth"
    t.string   "value"
    t.integer  "level"
    t.integer  "status"
    t.boolean  "dirty"
    t.datetime "from"
    t.datetime "until"
  end

  add_index "paths", ["ancestry"], :name => "index_paths_on_ancestry"
  add_index "paths", ["domain_id", "path_id"], :name => "index_paths_on_domain_id_and_path_id"
  add_index "paths", ["domain_id", "value"], :name => "index_paths_on_domain_id_and_value"
  add_index "paths", ["from"], :name => "index_paths_on_from"
  add_index "paths", ["path_id"], :name => "paths_path_id_fk"
  add_index "paths", ["until"], :name => "index_paths_on_until"
  add_index "paths", ["uuid"], :name => "index_paths_on_uuid", :unique => true

  create_table "properties", :force => true do |t|
    t.string   "uuid",              :null => false
    t.integer  "property_group_id"
    t.string   "code"
    t.string   "name"
    t.integer  "int_value"
    t.string   "text_value"
    t.datetime "date_value"
    t.integer  "row_order"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  add_index "properties", ["property_group_id", "code"], :name => "index_properties_on_property_group_id_and_code"
  add_index "properties", ["property_group_id", "row_order"], :name => "index_properties_on_property_group_id_and_row_order"
  add_index "properties", ["uuid"], :name => "index_properties_on_uuid", :unique => true

  create_table "property_groups", :force => true do |t|
    t.string   "uuid",              :null => false
    t.integer  "property_group_id"
    t.string   "code"
    t.string   "name"
    t.text     "description"
    t.boolean  "active"
    t.string   "type"
    t.integer  "row_order"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  add_index "property_groups", ["code"], :name => "index_property_groups_on_code"
  add_index "property_groups", ["property_group_id"], :name => "index_property_groups_on_property_group_id"
  add_index "property_groups", ["row_order"], :name => "index_property_groups_on_row_order"
  add_index "property_groups", ["uuid"], :name => "index_property_groups_on_uuid", :unique => true

  create_table "screen_shots", :force => true do |t|
    t.string   "uuid",       :null => false
    t.integer  "domain_id"
    t.integer  "page_id"
    t.string   "directory"
    t.datetime "from"
    t.datetime "until"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "screen_shots", ["domain_id"], :name => "index_screen_shots_on_domain_id"
  add_index "screen_shots", ["from"], :name => "index_screen_shots_on_from"
  add_index "screen_shots", ["page_id"], :name => "index_screen_shots_on_page_id"
  add_index "screen_shots", ["until"], :name => "index_screen_shots_on_until"
  add_index "screen_shots", ["uuid"], :name => "index_screen_shots_on_uuid", :unique => true

  create_table "statistics", :force => true do |t|
    t.integer  "domain_id"
    t.integer  "area_id"
    t.integer  "path_id"
    t.integer  "page_id"
    t.integer  "statistic_type_property_id"
    t.integer  "statistic_scope_property_id"
    t.datetime "from"
    t.datetime "until"
    t.integer  "pages_total"
    t.integer  "pages_active"
    t.integer  "pages_inactive"
    t.integer  "pages_new"
    t.integer  "pages_maintenance"
    t.integer  "pages_warning"
    t.integer  "pages_critical"
    t.integer  "pages_ok"
    t.integer  "pages_with_broken_links"
    t.integer  "pages_with_wrong_language"
    t.integer  "pages_old"
    t.integer  "pages_small"
    t.integer  "pages_huge"
    t.integer  "pages_slow"
    t.integer  "page_rank"
    t.integer  "page_speed"
    t.integer  "y_slow"
    t.integer  "links_internal"
    t.integer  "links_internal_broken"
    t.integer  "links_external"
    t.integer  "links_external_broken"
    t.integer  "links_file"
    t.integer  "links_file_broken"
    t.integer  "headlines"
    t.integer  "paragraphs"
    t.integer  "words"
    t.integer  "characters"
    t.integer  "images"
  end

  add_index "statistics", ["area_id"], :name => "index_statistics_on_area_id"
  add_index "statistics", ["domain_id"], :name => "index_statistics_on_domain_id"
  add_index "statistics", ["from"], :name => "index_statistics_on_from"
  add_index "statistics", ["page_id"], :name => "index_statistics_on_page_id"
  add_index "statistics", ["path_id"], :name => "index_statistics_on_path_id"
  add_index "statistics", ["statistic_scope_property_id"], :name => "index_statistics_on_statistic_scope_property_id"
  add_index "statistics", ["statistic_type_property_id"], :name => "index_statistics_on_statistic_type_property_id"
  add_index "statistics", ["until"], :name => "index_statistics_on_until"

  create_table "users", :force => true do |t|
    t.string   "uuid",              :null => false
    t.integer  "account_id"
    t.string   "user_name"
    t.string   "email"
    t.string   "phone"
    t.string   "first_name"
    t.string   "last_name"
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
  add_index "users", ["last_name"], :name => "index_users_on_last_name"
  add_index "users", ["user_name"], :name => "index_users_on_user_name"
  add_index "users", ["uuid"], :name => "index_users_on_uuid", :unique => true

  add_foreign_key "areas", "domains", :name => "areas_domain_id_fk"

  add_foreign_key "checks", "domains", :name => "checks_domain_id_fk"
  add_foreign_key "checks", "pages", :name => "checks_page_id_fk"

  add_foreign_key "containers", "containers", :name => "containers_container_id_fk"
  add_foreign_key "containers", "domains", :name => "containers_domain_id_fk"

  add_foreign_key "contents", "containers", :name => "contents_container_id_fk"

  add_foreign_key "domains", "accounts", :name => "domains_account_id_fk"

  add_foreign_key "page_contents", "contents", :name => "page_contents_content_id_fk"
  add_foreign_key "page_contents", "pages", :name => "page_contents_page_id_fk"

  add_foreign_key "page_properties", "pages", :name => "page_properties_page_id_fk"
  add_foreign_key "page_properties", "properties", :name => "page_properties_property_id_fk"

  add_foreign_key "pages", "areas", :name => "pages_area_id_fk"
  add_foreign_key "pages", "domains", :name => "pages_domain_id_fk"
  add_foreign_key "pages", "paths", :name => "pages_path_id_fk"

  add_foreign_key "paths", "domains", :name => "paths_domain_id_fk"
  add_foreign_key "paths", "paths", :name => "paths_path_id_fk"

  add_foreign_key "properties", "property_groups", :name => "properties_property_group_id_fk"

  add_foreign_key "property_groups", "property_groups", :name => "property_groups_property_group_id_fk"

  add_foreign_key "screen_shots", "domains", :name => "screen_shots_domain_id_fk"
  add_foreign_key "screen_shots", "pages", :name => "screen_shots_page_id_fk"

  add_foreign_key "users", "accounts", :name => "users_account_id_fk"

end
