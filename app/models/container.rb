class Container < ActiveRecord::Base
  attr_accessible :ignore, :name, :x_path

  belongs_to :domain
end
