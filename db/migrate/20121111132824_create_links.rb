class CreateLinks < ActiveRecord::Migration
  def change
    create_table :links do |t|
      t.references :content
      t.references :page

      t.timestamps
    end

    add_index :links, :content_id
    add_index :links, :page_id
  end
end
