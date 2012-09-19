class CreateDomains < ActiveRecord::Migration
  def change
    create_table :domains do |t|
      t.string :name
      t.text :description
      t.string :url
      t.integer :sortorder
      
      t.timestamps
    end
    add_index :domains, :name
    add_index :domains, :sortorder
  end
end
