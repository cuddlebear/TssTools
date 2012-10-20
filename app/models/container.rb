class Container < ActiveRecord::Base
  attr_accessible :container_id, :domain_id, :content_type_property_id,
                  :name, :x_path, :ignore

  belongs_to :container
  belongs_to :domain
  belongs_to :content_type_property, class_name: Property, :foreign_key => "content_type_property_id"

  has_many   :containers
  has_many   :contents

  validates :domain_id, :presence => true
  validates :name,      :presence => true
  validates :x_path,    :presence => true

  include RankedModel
  ranks :row_order

  before_save do |record|
    record.name = record.name.strip
    record.x_path = record.x_path.strip
  end
end
