class Content < ActiveRecord::Base
  attr_accessible :container_id, :md5_hash, :text, :language_property_id,
                  :links_internal, :links_internal_broken, :links_external, :links_external_broken,
                  :links_file, :links_file_broken

  belongs_to  :container
  belongs_to  :language_property, class_name: Property, :foreign_key => "language_property_id"

  has_many    :page_contents
  has_many    :pages, :through => :page_contents
  has_many    :links
  has_many    :refered_pages, :source => :page, :through => :links

  validates :container_id, :presence => true

end
