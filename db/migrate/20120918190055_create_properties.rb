class CreateProperties < ActiveRecord::Migration
  def change
    create_table :properties do |t|
      t.string :value
      t.references :property_group
      t.integer :sortorder
      
      t.timestamps
    end
    add_index :properties, :sortorder
  end
end
