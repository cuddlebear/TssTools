class Page < ActiveRecord::Base
  attr_accessible :domain_id, :area_id, :active, :path, :title, :status,
                  :page_rank, :page_speed, :y_slow,
                  :check_counter,
                  :last_change, :last_check, :last_publish,
                  :area_is_dirty, :actual_content

  belongs_to  :domain
  belongs_to  :area
  has_many    :properties, :through => :page_properties
  has_many    :page_contents
  has_many    :checks

  validates :domain_id, :presence => true
  validates :path, :presence => true
  validates :path, :format => { :with => /^[^ ]*$/,
                                       :message => "No spaces in URLs allowed" }

  before_create do |record|
    record.active = true
    record.status = 0    # new
  end

  after_create do |record| # create default page
    record.status = 0    # new
    record.save
    record.checks.create(priority: 1, type:100, scheduled_start: DateTime.now)
  end

  before_destroy do |record| #delete all related objects
    record.checks.destroy_all
    #record.page_properties.properties.destroy_all
    #record.page_properties.destroy_all
  end

end
