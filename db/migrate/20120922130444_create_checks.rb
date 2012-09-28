class CreateChecks < ActiveRecord::Migration
  def up
    create_table :checks do |t|
      t.references  :page
      t.integer     :priority
      t.integer     :type
      t.integer     :result_code
      t.string      :result_text
      t.datetime    :scheduled_start
      t.datetime    :check_start
      t.integer     :duration

      t.timestamps
    end
    add_index :checks, :page_id

    add_foreign_key(:checks, :pages)
  end

  def down
    drop_table :checks
  end
end
