class Check < ActiveRecord::Base
  attr_accessible :priority, :resultCode, :resultText, :type, :url
  belongs_to :url
end
