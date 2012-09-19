class Property < ActiveRecord::Base
  attr_accessible :PropertyGroup, :value
  belongs_to :propertyG_group
  has_many :urls, :through => :url_properties
end
