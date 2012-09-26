class CreateChecks < ActiveRecord::Migration
  def up
    create_table :checks do |t|
      t.references :page
      t.integer :priority
      t.integer :type
      t.integer :resultCode
      t.string :resultText
      t.datetime :scheduledStart
      t.datetime :checkStart
      t.integer :duration

      t.timestamps
    end

    add_foreign_key(:checks, :pages)
  end

  def down
    drop_table :checks
  end
end
