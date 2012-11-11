class CreateContainers < ActiveRecord::Migration
  def change
    create_table :containers do |t|
      t.string      :uuid, :null => false
      t.integer     :container_id
      t.references  :domain
      t.references  :content_type_property
      t.string      :name
      t.string      :x_path
      t.boolean     :ignore
      t.integer     :row_order

      t.timestamps
    end

    add_index :containers, :uuid, :unique => true
    add_index :containers, :domain_id
    add_index :containers, :container_id
    add_index :containers, :content_type_property_id

    add_foreign_key(:containers, :domains)
    add_foreign_key(:containers, :containers)

  end
end
