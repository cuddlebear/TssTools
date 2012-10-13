class CreateContainers < ActiveRecord::Migration
  def change
    create_table :containers do |t|
      t.integer     :container_id
      t.references  :domain
      t.string      :name
      t.string      :x_path
      t.boolean     :ignore

      t.timestamps
    end

    add_index :containers, :domain_id
    add_index :containers, :container_id

    add_foreign_key(:containers, :domains)
    add_foreign_key(:containers, :containers)

  end
end
