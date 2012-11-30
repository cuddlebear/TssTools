class Link < ActiveRecord::Base
  attr_accessible :content_id, :page_id, :from, :until

  belongs_to :content
  belongs_to :page

  before_save do |record|
    record.from = DateTime.now if record.from.nil?
    record.until = DateTime.new(3000,1,1,0,0,0) if record.until.nil?
  end
end
