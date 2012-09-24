class Url < ActiveRecord::Base
  attr_accessible :path, :domain_id
  belongs_to :domain
  has_many :properties, :through => :url_properties
  validates :path, :presence => true
  validates :domain_id, :presence => true
end
