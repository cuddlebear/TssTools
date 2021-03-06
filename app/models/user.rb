class User < ActiveRecord::Base
  attr_accessible :user_name, :email, :phone, :first_name, :last_name,
                  :address1, :address2, :address3, :zip, :city, :country, :state,
                  :crypted_password, :password_salt, :persistence_token,
                  :active, :locked, :account_admin, :super_admin


  belongs_to :account

  validates :email, :presence => true
  validates :last_name, :presence => true
  validates :uuid, :presence => true, :uniqueness => true

  before_validation(:on => :create) do
    self.uuid = UUIDTools::UUID.random_create.to_s
  end

end
