class Area < ActiveRecord::Base
  attr_accessible :domain_id, :filter, :filter_type_property_id, :interval_property_id, :name, :sort_order

  has_many    :pages
  belongs_to  :domain
  belongs_to  :filter_type_property, class_name: Property, :foreign_key => "filter_type_property_id"
  belongs_to  :interval_property, class_name: Property, :foreign_key => "interval_property_id"

  validates :filter, :presence => true
  validates :filter_type_property_id, :presence => true


  # filterType
  # 0 = Begins with
  # 1 = Contains
  # 2 = Regular Expression
end
