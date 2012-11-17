class Link < ActiveRecord::Base
  attr_accessible :content_id, :page_id

  belongs_to :content
  belongs_to :page
end
