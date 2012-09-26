class CreatePropertyGroups < ActiveRecord::Migration
  def up
    create_table :property_groups do |t|
      t.string :name
      t.text :description
      t.boolean :active
      t.integer :sortorder

      t.timestamps
    end

    add_index :property_groups, :sortorder
  end

  def down
    drop_table :property_groups
  end
end
