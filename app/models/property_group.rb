class PropertyGroup < ActiveRecord::Base
  attr_accessible :property_group_id, :code, :name, :description, :active, :type, :row_order

  has_many :properties
  has_many :propertyGroups
  belongs_to :propertyGroup

  validates :name, :presence => true

  include RankedModel
  ranks :row_order

  before_save do |record|
    if record.code.nil? or record.code.empty?
      record.code= record.name.downcase.gsub(/[^a-z0-9]/,"_").gsub(/__+/,"_")
    end
    if record.type.nil? or record.type.empty?
      record.type= "int"
    end
    if record.row_order.nil? or record.row_order == 0
      record.row_order_position = PropertyGroup.count + 1
    end
  end

end
