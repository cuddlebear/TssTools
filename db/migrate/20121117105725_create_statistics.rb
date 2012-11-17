class CreateStatistics < ActiveRecord::Migration
  def change
    create_table :statistics do |t|
      t.references  :domain
      t.references  :area
      t.references  :path
      t.references  :page
      t.references  :statistic_type_property
      t.references  :statistic_scope_property

      t.datetime    :from
      t.datetime    :until

      t.integer     :pages_total
      t.integer     :pages_active
      t.integer     :pages_inactive

      t.integer     :pages_new
      t.integer     :pages_maintenance
      t.integer     :pages_warning
      t.integer     :pages_critical
      t.integer     :pages_ok

      t.integer     :pages_with_broken_links
      t.integer     :pages_with_wrong_language
      t.integer     :pages_old
      t.integer     :pages_small
      t.integer     :pages_huge
      t.integer     :pages_slow

      t.integer     :page_rank
      t.integer     :page_speed
      t.integer     :y_slow

      t.integer     :links_internal
      t.integer     :links_internal_broken
      t.integer     :links_external
      t.integer     :links_external_broken
      t.integer     :links_file
      t.integer     :links_file_broken

      t.integer     :headlines
      t.integer     :paragraphs
      t.integer     :words
      t.integer     :characters
      t.integer     :images
    end

    add_index :statistics, :domain_id
    add_index :statistics, :area_id
    add_index :statistics, :path_id
    add_index :statistics, :page_id
    add_index :statistics, :statistic_type_property_id
    add_index :statistics, :statistic_scope_property_id
    add_index :statistics, :from
    add_index :statistics, :until
  end
end
