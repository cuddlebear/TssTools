class CreateContents < ActiveRecord::Migration
  def up
    create_table :contents do |t|
      t.references  :container
      t.string      :md5_hash
      t.text        :text

      t.timestamps
    end

    add_index :contents, :container_id
    add_index :contents, :md5_hash
  end

  def down
    drop_table :contents
  end

end
