class CreateContents < ActiveRecord::Migration
  def change
    create_table :contents do |t|
      t.references  :container
      t.string      :hash
      t.string      :text

      t.timestamps
    end
    add_index :contents, :container_id
  end
end
