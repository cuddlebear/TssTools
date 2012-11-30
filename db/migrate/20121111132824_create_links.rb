class CreateLinks < ActiveRecord::Migration
  def change
    create_table :links do |t|
      t.references  :content
      t.references  :page
      t.datetime    :from
      t.datetime    :until
    end

    add_index :links, :content_id
    add_index :links, :page_id
    add_index :links, :from
    add_index :links, :until
  end
end
