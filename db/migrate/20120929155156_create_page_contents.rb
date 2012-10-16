class CreatePageContents < ActiveRecord::Migration
  def up
    create_table :page_contents do |t|
      t.references  :page
      t.references  :content
      t.datetime    :from
      t.datetime    :until

      t.timestamps
    end
    add_index :page_contents, :page_id
    add_index :page_contents, :content_id
    add_index :page_contents, [:page_id, :content_id]

    add_foreign_key(:page_contents, :pages)
    add_foreign_key(:page_contents, :contents)
  end

  def down
    drop_table :page_contents
  end

end
