class PageProperty < ActiveRecord::Base
  belongs_to :page
  belongs_to :property
end
