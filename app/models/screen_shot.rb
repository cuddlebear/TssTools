class ScreenShot < ActiveRecord::Base
  attr_accessible :uuid, :domain_id, :page_id, :directory, :from, :until

  belongs_to :domain
  belongs_to :page

  validates :uuid, :presence => true, :uniqueness => true
  validates :domain_id, :presence => true
  validates :page_id, :presence => true
  validates :directory, :presence => true

  before_validation(:on => :create) do
    self.uuid = UUIDTools::UUID.random_create.to_s if self.uuid.nil?
  end

end
