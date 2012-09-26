class Check < ActiveRecord::Base
  attr_accessible :priority, :type, :resultCode, :resultText, :scheduledStart, :checkStart, :duration
  belongs_to :page
end
