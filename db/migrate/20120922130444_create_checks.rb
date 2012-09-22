class CreateChecks < ActiveRecord::Migration
  def change
    create_table :checks do |t|
      t.references :url
      t.integer :priority
      t.integer :type
      t.integer :resultCode
      t.string :resultText

      t.timestamps
    end
    add_index :checks, :url_id
  end
end
