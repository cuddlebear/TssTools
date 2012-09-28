class Check < ActiveRecord::Base
  attr_accessible :priority, :type, :result_code, :result_text, :scheduled_start, :check_start, :duration
  belongs_to :page
end
