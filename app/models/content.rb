class Content < ActiveRecord::Base
  attr_accessible :md5_hash, :text

  belongs_to  :container
  belongs_to  :page_content

end
