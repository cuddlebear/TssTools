class Statistic < ActiveRecord::Base
  attr_accessible :from, :until

  belongs_to :domain
  belongs_to :area
  belongs_to :path
  belongs_to :page

  belongs_to  :statistic_type_property,   class_name: Property, :foreign_key => "statistic_type_property_id"
  belongs_to  :statistic_scope_property,  class_name: Property, :foreign_key => "statistic_scope_property_id"


end
