class Area < ActiveRecord::Base
  attr_accessible :domain_id, :filter_type_property_id, :interval_property_id, :language_code_property_id,
                  :name, :filter, :row_order

  has_many    :pages
  belongs_to  :domain
  belongs_to  :filter_type_property,   class_name: Property, :foreign_key => "filter_type_property_id"
  belongs_to  :interval_property,      class_name: Property, :foreign_key => "interval_property_id"
  belongs_to  :language_code_property, class_name: Property, :foreign_key => "language_code_property_id"

  validates :domain_id,               :presence => true
  validates :filter,                  :presence => true
  validates :filter_type_property_id, :presence => true
  validates :interval_property_id,    :presence => true
  validates :uuid, :presence => true, :uniqueness => true

  include RankedModel
  ranks :row_order

  before_validation(:on => :create) do
    self.uuid = UUIDTools::UUID.random_create.to_s
  end

  before_save do |record|
    if record.row_order.nil? or record.row_order == 0
      record.row_order_position = Area.where(:domain_id => record.domain_id).count + 1
    end
  end

end
