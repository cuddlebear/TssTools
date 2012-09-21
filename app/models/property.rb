class Property < ActiveRecord::Base
  attr_accessible :PropertyGroup, :value
  belongs_to :property_group
  has_many :urls, :through => :url_properties
  validates :value, :presence => true
end
