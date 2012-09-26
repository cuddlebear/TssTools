class Account < ActiveRecord::Base
  attr_accessible :name, :description, :active, :locked

  has_many :users
  has_many :domains

  validates :name, :presence => true

end
