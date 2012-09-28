class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.references  :account
      t.string      :user_name
      t.string      :email
      t.string      :phone
      t.string      :first_name
      t.string      :last_name
      t.string      :company
      t.string      :address1
      t.string      :address2
      t.string      :address3
      t.string      :zip
      t.string      :city
      t.string      :country
      t.string      :state
      t.string      :crypted_password
      t.string      :password_salt
      t.string      :persistence_token
      t.boolean     :active
      t.boolean     :locked
      t.boolean     :account_admin
      t.boolean     :super_admin
      t.timestamps
    end

    add_index :users, :account_id
    add_index :users, :email
    add_index :users, :user_name
    add_index :users, :last_name

    add_foreign_key(:users, :accounts)
  end

  def self.down
    drop_table :users
  end
end