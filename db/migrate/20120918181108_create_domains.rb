class CreateDomains < ActiveRecord::Migration
  def up
    create_table :domains do |t|
      t.string :name
      t.text :description
      t.string :path
      t.integer :sortorder
      
      t.timestamps
    end

    add_index :domains, :name
    add_index :domains, :path
    add_index :domains, :sortorder
  end

  def down
    drop_table :domains
  end
end
