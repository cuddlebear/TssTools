class CreateChecks < ActiveRecord::Migration
  def up
    create_table :checks do |t|
      t.string      :uuid, :null => false
      t.references  :domain
      t.references  :page
      t.integer     :priority
      t.integer     :type
      t.integer     :result_code
      t.string      :result_text
      t.datetime    :scheduled_start
      t.boolean     :in_process
      t.datetime    :check_start
      t.integer     :duration

      t.timestamps
    end
    add_index :checks, :uuid, :unique => true
    add_index :checks, :domain_id
    add_index :checks, :page_id
    add_index :checks, :scheduled_start
    add_index :checks, :check_start

    add_foreign_key(:checks, :domains)
    add_foreign_key(:checks, :pages)
  end

  def down
    drop_table :checks
  end
end
