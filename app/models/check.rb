class Check < ActiveRecord::Base
  attr_accessible :domain_id, :page_id, :priority, :type, :result_code, :result_text,
                  :scheduled_start, :check_start, :duration
  set_inheritance_column :ruby_type

  belongs_to :page

  before_validation(:on => :create) do
    self.uuid = UUIDTools::UUID.random_create.to_s
  end
end
