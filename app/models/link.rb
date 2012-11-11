class Link < ActiveRecord::Base
  belongs_to :content
  belongs_to :page
  # attr_accessible :title, :body
end
