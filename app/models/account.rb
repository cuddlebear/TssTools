class Account < ActiveRecord::Base
  attr_accessible :name, :description, :active, :locked

  has_many :users
  has_many :domains

  validates :name, :presence => true
  validates :uuid, :presence => true, :uniqueness => true

  before_validation(:on => :create) do
    self.uuid = UUIDTools::UUID.random_create.to_s
  end

end
