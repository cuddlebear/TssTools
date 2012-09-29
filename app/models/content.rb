class Content < ActiveRecord::Base
  attr_accessible :hash, :text

  belongs_to  :container
  belongs_to  :page_content

end
