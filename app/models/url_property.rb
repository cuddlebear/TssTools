class UrlProperty < ActiveRecord::Base
  belongs_to :url
  belongs_to :property
  # attr_accessible :title, :body
end
