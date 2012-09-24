class CreateUrlProperties < ActiveRecord::Migration
  def up
    create_table :url_properties do |t|
      t.references :url
      t.references :property

      t.timestamps
    end

    add_index :url_properties, :url_id
    add_index :url_properties, :property_id

    add_foreign_key(:url_properties, :properties)
    add_foreign_key(:url_properties, :urls)
  end

  def down
    drop_table :url_properties
  end
end
