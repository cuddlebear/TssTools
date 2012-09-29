class CreatePageContents < ActiveRecord::Migration
  def change
    create_table :page_contents do |t|
      t.references :page
      t.referenes :content
      t.datetime :from
      t.datetime :until

      t.timestamps
    end
    add_index :page_contents, :page_id
  end
end
