class CreateAccounts < ActiveRecord::Migration
  def up
    create_table :accounts do |t|
      t.string      :uuid, :null => false
      t.string      :name
      t.string      :description
      t.boolean     :active
      t.boolean     :locked

      t.timestamps
    end

    add_index :accounts, :uuid, :unique => true
    add_index :accounts, :name
  end

  def down
  end
end
