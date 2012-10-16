class CreatePageProperties < ActiveRecord::Migration
  def up
    create_table :page_properties do |t|
      t.references :page
      t.references :property

      t.timestamps
    end

    add_index :page_properties, :page_id
    add_index :page_properties, :property_id

    add_foreign_key(:page_properties, :pages)
    add_foreign_key(:page_properties, :properties)
  end

  def down
    drop_table :page_properties
  end
end
