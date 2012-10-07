class CreateContents < ActiveRecord::Migration
  def up
    create_table :contents do |t|
      t.references  :container
      t.string      :hash
      t.text        :text

      t.timestamps
    end

    add_index :contents, :container_id
  end

  def down
    drop_table :contents
  end

end
