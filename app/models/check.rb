class Check < ActiveRecord::Base
  attr_accessible :page_id, :priority, :type, :result_code, :result_text,
                  :scheduled_start, :check_start, :duration
  set_inheritance_column :ruby_type

  belongs_to :page
end
