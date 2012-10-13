class PropertyGroup < ActiveRecord::Base
  attr_accessible :name, :description, :active, :sort_order

  has_many :properties
  has_many :propertyGroups
  belongs_to :propertyGroup

  validates :name, :presence => true
end
