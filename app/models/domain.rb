class Domain < ActiveRecord::Base
  attr_accessible :description, :name
  has_many :urls
end
