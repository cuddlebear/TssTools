class Url < ActiveRecord::Base
  attr_accessible :path, :url
  belongs_to :domain
  has_many :properties, :through => :url_properties 
  validates :url, :presence => true
end
