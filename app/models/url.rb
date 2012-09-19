class Url < ActiveRecord::Base
  attr_accessible :, :path
  belongs_to :domain
end
