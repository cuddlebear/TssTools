class PropertyGroup < ActiveRecord::Base
  attr_accessible :property_group_id, :code, :name, :description, :active, :type, :sort_order

  has_many :properties
  has_many :propertyGroups
  belongs_to :propertyGroup

  validates :name, :presence => true


  before_save do |record|
    if record.code.nil? or record.code.empty?
      record.code= record.name.downcase.gsub(/[^a-z0-9]/,"_").gsub(/__+/,"_")
    end
    if record.type.nil? or record.type.empty?
      record.type= "int"
    end
    if record.sort_order.nil? or record.sort_order == 0
      record.sort_order= PropertyGroup.count + 1
    end
  end

end
