class CreateProperties < ActiveRecord::Migration
  def up
    create_table :properties do |t|
      t.references  :property_group
      t.string      :code
      t.string      :name
      t.integer     :int_value
      t.string      :text_value
      t.datetime    :date_value
      t.integer     :row_order
      
      t.timestamps
    end

    add_index :properties, [:property_group_id, :code]
    add_index :properties, [:property_group_id, :row_order]

    add_foreign_key(:properties, :property_groups)
  end

  def down
    drop_table :properties
  end
end
