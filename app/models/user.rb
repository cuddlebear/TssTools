class User < ActiveRecord::Base
  attr_accessible :username, :email, :phone, :firstName, :lastName,
                  :address1, :address2, :address3, :zip, :city, :country, :state,
                  :crypted_password, :password_salt, :persistence_token,
                  :active, :locked, :accountAdmin, :superAdmin


  belongs_to :account

  validates :email, :presence => true
  validates :lastName, :presence => true

end
