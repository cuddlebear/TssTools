class CreateContainers < ActiveRecord::Migration
  def change
    create_table :containers do |t|
      t.references  :domain
      t.string      :name
      t.string      :x_path
      t.boolean     :ignore

      t.timestamps
    end

    add_index :containers, :domain_id

    add_foreign_key(:containers, :domains)

  end
end
