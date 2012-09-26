class PageProperty < ActiveRecord::Base
  belongs_to :page
  belongs_to :property
  # attr_accessible :title, :body
end
