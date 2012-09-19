class Url < ActiveRecord::Base
  attr_accessible :, :path
  belongs_to :domain
  has_many :properties, :through => :url_properties 
end
