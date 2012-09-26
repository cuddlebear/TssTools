class PropertyGroup < ActiveRecord::Base
  attr_accessible :name, :description, :active, :sortorder
  has_many :properties
  validates :name, :presence => true
end
