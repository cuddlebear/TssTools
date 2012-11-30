class Path < ActiveRecord::Base
  attr_accessible :domain_id, :path_id, :level, :value, :from, :until

  belongs_to   :domain
  belongs_to   :path
  has_many     :pages
  has_many     :paths
  has_ancestry :cache_depth => true

  validates :domain_id, :presence => true
  validates :uuid, :presence => true, :uniqueness => true

  before_validation(:on => :create) do
    self.uuid = UUIDTools::UUID.random_create.to_s
  end

  before_save do |record|
    record.level = record.value.count("/")
    record.from = DateTime.now if record.from.nil?
    record.until = DateTime.new(3000,1,1,0,0,0) if record.until.nil?
  end

end
