class CreatePropertyGroups < ActiveRecord::Migration
  def up
    create_table :property_groups do |t|
      t.string      :uuid, :null => false
      t.integer     :property_group_id
      t.string      :code
      t.string      :name
      t.text        :description
      t.boolean     :active
      t.string      :type
      t.integer     :row_order

      t.timestamps
    end

    add_index :property_groups, :uuid, :unique => true
    add_index :property_groups, :row_order
    add_index :property_groups, :code
    add_index :property_groups, :property_group_id

    add_foreign_key(:property_groups, :property_groups)
  end

  def down
    drop_table :property_groups
  end
end
