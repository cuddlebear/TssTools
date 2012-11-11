class CreateScreenShots < ActiveRecord::Migration
  def up
    create_table :screen_shots do |t|
      t.string     :uuid,  :null => false
      t.references :domain
      t.references :page
      t.string     :directory
      t.datetime   :from
      t.datetime   :until

      t.timestamps
    end
    add_index :screen_shots, :uuid, :unique => true
    add_index :screen_shots, :domain_id
    add_index :screen_shots, :page_id
    add_index :screen_shots, :from
    add_index :screen_shots, :until

    add_foreign_key(:screen_shots, :domains)
    add_foreign_key(:screen_shots, :pages)

  end

  def down
    drop_table :screen_shots
  end
end
