class Content < ActiveRecord::Base
  attr_accessible :container_id, :md5_hash, :text, :language_property_id,
                  :links_internal, :links_internal_broken, :links_external, :links_external_broken,
                  :links_file, :links_file_broken

  belongs_to  :container
  has_many    :page_contents
  has_many    :pages, :through => :page_contents

  validates :container_id, :presence => true

end
