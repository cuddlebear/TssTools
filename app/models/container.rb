class Container < ActiveRecord::Base
  attr_accessible :container_id, :domain_id, :name, :x_path, :ignore

  belongs_to :domain
  belongs_to :container
  has_many   :containers

  validates :domain_id, :presence => true
  validates :name,      :presence => true
  validates :x_path,    :presence => true

  before_save do |record|
    record.name = record.name.strip
    record.x_path = record.x_path.strip
  end
end
