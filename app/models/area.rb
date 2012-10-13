class Area < ActiveRecord::Base
  attr_accessible :domain_id, :name, :filter, :filter_type_property_id, :interval_property_id, :language_code, :sort_order

  has_many    :pages
  belongs_to  :domain
  belongs_to  :filter_type_property, class_name: Property, :foreign_key => "filter_type_property_id"
  belongs_to  :interval_property, class_name: Property, :foreign_key => "interval_property_id"

  validates :domain_id,               :presence => true
  validates :filter,                  :presence => true
  validates :filter_type_property_id, :presence => true

  before_save do |record|
    if record.sort_order.nil? or record.sort_order.empty?
      record.sort_order = Area.where(:domain_id => record.domain_id).count + 1
    end
  end

end
