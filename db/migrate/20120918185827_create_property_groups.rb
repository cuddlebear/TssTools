class CreatePropertyGroups < ActiveRecord::Migration
  def change
    create_table :property_groups do |t|
      t.string :name
      t.text :description
      t.integer :sortorder

      t.timestamps
    end
    add_index :property_groups, :sortorder
  end
end
