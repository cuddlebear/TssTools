class PageProperty < ActiveRecord::Base
  belongs_to :page
  belongs_to :property

  validates :page_id,    :presence => true

end
