class CreateAreas < ActiveRecord::Migration
  def up
    create_table :areas do |t|
      t.references  :domain
      t.string      :name
      t.string      :filter
      t.integer     :filterType
      t.references  :property
      t.integer     :sortOrder

      t.timestamps
    end
    add_index :areas, :domain_id
    add_index :areas, :property_id
    add_index :areas, :sortOrder

    add_foreign_key(:areas, :domains)
    add_foreign_key(:areas, :properties)
  end

  def down
    drop_table :areas
  end
end
