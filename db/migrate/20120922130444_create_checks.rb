class CreateChecks < ActiveRecord::Migration
  def up
    create_table :checks do |t|
      t.references :url
      t.integer :priority
      t.integer :type
      t.integer :resultCode
      t.string :resultText
      t.datetime :scheduledStart
      t.datetime :checkStart
      t.integer :duration

      t.timestamps
    end
    add_index :checks, :url_id

    add_foreign_key(:checks, :urls)
  end

  def down
    drop_table :checks
  end
end
