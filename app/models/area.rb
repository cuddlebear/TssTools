class Area < ActiveRecord::Base
  attr_accessible :domain_id, :filter, :filterType, :name, :sortOrder

  belongs_to :domain

  validates :filter, :presence => true
  validates :filterType, :presence => true


  # filterType
  # 0 = Begins with
  # 1 = Contains
  # 2 = Regular Expression
end
