class Domain < ActiveRecord::Base
  attr_accessible :description, :name, :url
  has_many :urls
  validates :name, :presence => true
  validates :url, :presence => true
  validates_associated :urls
end
