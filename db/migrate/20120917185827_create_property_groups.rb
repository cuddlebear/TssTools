class CreatePropertyGroups < ActiveRecord::Migration
  def up
    create_table :property_groups do |t|
      t.string    :name
      t.text      :description
      t.boolean   :active
      t.integer   :sort_order

      t.timestamps
    end

    add_index :property_groups, :sort_order
  end

  def down
    drop_table :property_groups
  end
end
