class Property < ActiveRecord::Base
  attr_accessible :property_group_id, :name, :value, :sort_order
  belongs_to :property_group
  has_many :pages, :through => :page_properties
  validates :name, :presence => true
  validates :value, :presence => true
end
