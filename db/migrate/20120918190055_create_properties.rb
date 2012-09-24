class CreateProperties < ActiveRecord::Migration
  def up
    create_table :properties do |t|
      t.string :value
      t.references :property_group
      t.integer :sortorder
      
      t.timestamps
    end

    add_index :properties, :sortorder

    add_foreign_key(:properties, :property_groups)
  end

  def down
    drop_table :properties
  end
end
