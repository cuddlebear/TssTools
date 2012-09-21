class CreateUrlProperties < ActiveRecord::Migration
  def change
    create_table :url_properties do |t|
      t.references :url
      t.references :property

      t.timestamps
    end
    add_index :url_properties, :url_id
    add_index :url_properties, :property_id
  end
end
