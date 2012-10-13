class PageContent < ActiveRecord::Base
  attr_accessible :page, :content, :from, :until

  belongs_to :page
  has_many :content

  #validates :content,    :presence => true

end
