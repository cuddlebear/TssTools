class CreateProperties < ActiveRecord::Migration
  def up
    create_table :properties do |t|
      t.references :property_group
      t.string :name
      t.integer :value
      t.integer :sortorder
      
      t.timestamps
    end

    add_index :properties, :property_group_id
    add_index :properties, :sortorder

    add_foreign_key(:properties, :property_groups)
  end

  def down
    drop_table :properties
  end
end
