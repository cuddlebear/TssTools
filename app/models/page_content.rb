class PageContent < ActiveRecord::Base
  attr_accessible :page, :content, :from, :until

  belongs_to :page
  has_one    :content

  validates :page_id,    :presence => true

end
