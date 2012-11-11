class CreatePages < ActiveRecord::Migration
  def up
    create_table :pages do |t|
      t.string      :uuid, :null => false
      t.references  :domain
      t.references  :area
      t.references  :path
      t.boolean     :active
      t.integer     :level
      t.string      :file_name
      t.string      :parameter
      t.string      :title
      t.integer     :status
      t.boolean     :check_for_content
      t.string      :content_to_check_for_existence
      t.string      :content_to_check_for_not_existence
      t.integer     :page_rank
      t.integer     :page_speed
      t.integer     :y_slow
      t.integer     :check_counter
      t.datetime    :last_change
      t.datetime    :last_check
      t.datetime    :last_publish
      t.boolean     :area_is_dirty
      t.boolean     :screen_shot
      t.integer     :max_screen_shots_per_page
      t.string      :actual_content
      t.timestamps
    end

    add_index :pages, :uuid, :unique => true
    add_index :pages, [:domain_id, :path_id, :file_name]
    add_index :pages, :area_id
    add_index :pages, :status
    add_index :pages, :level
    add_index :pages, :last_change
    add_index :pages, :last_check
    add_index :pages, :last_publish

    add_foreign_key(:pages, :domains)
    add_foreign_key(:pages, :areas)
    add_foreign_key(:pages, :paths)
  end

  def down
    drop_table :pages
  end

end
