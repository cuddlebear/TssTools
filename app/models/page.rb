class Page < ActiveRecord::Base
  attr_accessible :domain_id, :path, :title, :active, :status,
                  :page_rank, :page_speed, :y_slow,
                  :check_counter, :last_check, :actual_content

  belongs_to  :domain
  belongs_to  :area
  has_many    :properties, :through => :page_properties
  has_many    :page_contents
  has_many    :checks

  validates :path, :presence => true
  validates :path, :format => { :with => /^[^ ]*$/,
                                       :message => "No spaces in URLs allowed" }
  validates :domain_id, :presence => true

  before_save do |record|

  end


  before_create do |record|
    record.active = true
    record.status = 0    # new
  end

  after_create do |record| # create default page
    record.status = 0    # new
    record.save
    record.checks.create(priority: 1, type:100, scheduled_start: DateTime.now)
  end


end
