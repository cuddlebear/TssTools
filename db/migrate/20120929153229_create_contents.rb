class CreateContents < ActiveRecord::Migration
  def up
    create_table :contents do |t|
      t.references  :container
      t.string      :md5_hash
      t.text        :text
      t.references  :language_property   # detected language
      t.integer     :links_internal
      t.integer     :links_internal_broken
      t.integer     :links_external
      t.integer     :links_external_broken
      t.integer     :links_file
      t.integer     :links_file_broken
      t.integer     :headlines
      t.integer     :paragraphs
      t.integer     :words
      t.integer     :characters
      t.integer     :images

      t.timestamps
    end

    add_index :contents, :container_id
    add_index :contents, :language_property_id
    add_index :contents, :md5_hash

    add_foreign_key(:contents, :containers)

  end

  def down
    drop_table :contents
  end

end
