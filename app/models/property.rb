class Property < ActiveRecord::Base
  attr_accessible :property_group_id,:code, :name, :int_value, :text_value, :date_value, :sort_order

  belongs_to :property_group
  has_many :pages, :through => :page_properties

  validates :property_group_id, :presence => true
  validates :name, :presence => true

  before_save do |record|
    if record.code.nil? or record.code.empty?
      record.code = record.name.downcase.gsub(/[[^a-z0-9]]/,"_").gsub(/__+/,"_")
    end
    if record.sort_order.nil? or record.sort_order == 0
      record.sort_order = Property.where(:property_group_id => record.property_group_id).count + 1
    end
  end

end
