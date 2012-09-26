class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.references  :account
      t.string      :username
      t.string      :email
      t.string      :phone
      t.string      :firstName
      t.string      :lastName
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
      t.boolean     :accountAdmin
      t.boolean     :superAdmin
      t.timestamps
    end

    add_index :users, :account_id
    add_index :users, :username
    add_index :users, :email

    add_foreign_key(:users, :accounts)
  end

  def self.down
    drop_table :users
  end
end