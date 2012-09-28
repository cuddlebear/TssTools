class PropertyGroup < ActiveRecord::Base
  attr_accessible :name, :description, :active, :sort_order

  has_many :properties

  validates :name, :presence => true
end
