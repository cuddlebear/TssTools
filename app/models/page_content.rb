class PageContent < ActiveRecord::Base
  attr_accessible :page, :content, :from, :until

  belongs_to :page
  belongs_to :content

  validates :page_id,    :presence => true

end
