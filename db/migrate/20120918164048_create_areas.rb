class CreateAreas < ActiveRecord::Migration
  def up
    create_table :areas do |t|
      t.references  :domain
      t.references  :filter_type_property
      t.references  :interval_property        # time interval for checking pages in this area
      t.string      :name
      t.string      :filter
      t.string      :language_code            # the language which is expected in this area
      t.integer     :row_order

      t.timestamps
    end
    add_index :areas, :domain_id
    add_index :areas, :filter_type_property_id
    add_index :areas, :interval_property_id
    add_index :areas, :row_order

    add_foreign_key(:areas, :domains)
    #add_foreign_key(:areas, :properties)
  end

  def down
    drop_table :areas
  end
end
