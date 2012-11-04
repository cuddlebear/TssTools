class CreateDomains < ActiveRecord::Migration
  def up
    create_table :domains do |t|
      t.string      :uuid, :null => false
      t.references  :account
      t.boolean     :active
      t.string      :name
      t.text        :description
      t.string      :scheme
      t.string      :domain
      t.string      :port
      t.integer     :status
      t.boolean     :check_page_rank
      t.boolean     :check_page_speed
      t.boolean     :check_y_slow
      t.boolean     :check_content_for_changes
      t.boolean     :check_publish_time
      t.string      :regx_publish_time
      t.integer     :row_order
      
      t.timestamps
    end

    add_index :domains, :uuid, :unique => true
    add_index :domains, :account_id
    add_index :domains, :name
    add_index :domains, :domain
    add_index :domains, :row_order

    add_foreign_key(:domains, :accounts)
  end

  def down
    drop_table :domains
  end
end
