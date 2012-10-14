class Property < ActiveRecord::Base
  attr_accessible :property_group_id,:code, :name, :int_value, :text_value, :date_value, :row_order

  belongs_to :property_group
  has_many :pages, :through => :page_properties

  validates :property_group_id, :presence => true
  validates :name, :presence => true

  include RankedModel
  ranks :row_order

  before_save do |record|
    if record.code.nil? or record.code.empty?
      record.code = record.name.downcase.gsub(/[[^a-z0-9]]/,"_").gsub(/__+/,"_")
    end
    if record.row_order.nil? or record.row_order == 0
      record.row_order_position = Property.where(:property_group_id => record.property_group_id).count + 1
    end
  end

end
