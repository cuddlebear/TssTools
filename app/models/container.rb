class Container < ActiveRecord::Base
  attr_accessible :domain_id, :ignore, :name, :x_path

  belongs_to :domain

  validates :name,    :presence => true
  validates :x_path,  :presence => true

  before_save do |record|
    record.name = record.name.strip
    record.x_path = record.x_path.strip
  end
end
