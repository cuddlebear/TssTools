class CreatePaths < ActiveRecord::Migration
  def up
    create_table :paths do |t|
      t.string      :uuid, :null => false
      t.references  :domain
      t.references  :path
      t.string      :ancestry
      t.integer     :ancestry_depth
      t.string      :value
      t.integer     :level
      t.integer     :status
      t.boolean     :dirty

      t.timestamps
    end

    add_index :paths, :uuid, :unique => true
    add_index :paths, :ancestry
    add_index :paths, [:domain_id, :value]
    add_index :paths, [:domain_id, :path_id]

    add_foreign_key(:paths, :domains)
    add_foreign_key(:paths, :paths)

  end

  def down
    drop_table :paths
  end

end
