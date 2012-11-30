class PageContent < ActiveRecord::Base
  attr_accessible :page, :content, :from, :until

  belongs_to :page
  belongs_to :content

  validates :page_id,    :presence => true

  before_save do |record|
    record.from = DateTime.now if record.from.nil?
    record.until = DateTime.new(3000,1,1,0,0,0) if record.until.nil?
  end

end
