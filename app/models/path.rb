class Path < ActiveRecord::Base
  attr_accessible :domain_id, :path_id, :level, :value

  belongs_to :domain
  belongs_to :path
  has_many   :pages
  has_many   :paths

  validates :domain_id, :presence => true
  validates :uuid, :presence => true, :uniqueness => true

  before_validation(:on => :create) do
    self.uuid = UUIDTools::UUID.random_create.to_s
  end

  before_save do |record|
    record.level = record.value.count("/")
  end

end
