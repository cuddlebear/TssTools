class CreateUrls < ActiveRecord::Migration
  def change
    create_table :urls do |t|
      t.string :path
      t.references :domains
      t.timestamps
    end
    add_index :urls, :path
    add_index :urls, :domain_id
  end  
    
end
