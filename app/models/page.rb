class Page < ActiveRecord::Base
  attr_accessible :domain_id, :area_id, :path_id, :active,
                  :level, :file_name, :parameter, :title, :status,
                  :page_rank, :page_speed, :y_slow,
                  :check_counter,
                  :last_change, :last_check, :last_publish, :from, :until,
                  :area_is_dirty, :actual_content,
                  :screen_shot, :max_screen_shots_per_page

  belongs_to  :domain
  belongs_to  :area
  belongs_to  :path
  has_many    :page_properties
  has_many    :properties, :through => :page_properties
  has_many    :page_contents
  has_many    :contents, :through => :page_contents
  has_many    :links
  has_many    :refering_links, :source => :contents, :through => :links
  has_many    :checks
  has_many    :screen_shots

  validates :domain_id, :presence => true
  validates :path, :presence => true
  validates :path, :format => { :with => /^[^ ]*$/,
                                       :message => "No spaces in URLs allowed" }
  validates :uuid, :presence => true, :uniqueness => true

  before_validation(:on => :create) do
    self.uuid = UUIDTools::UUID.random_create.to_s
  end

  before_create do |record|
    record.active = true
    record.status = 0    # new
  end

  after_create do |record| # create default page
    record.status = 0    # new
    record.save
    record.checks.create(domain_id: record.domain_id,priority: 1, type:100, scheduled_start: DateTime.now)
  end

  before_save do |record|
    #record.level = Path.find_last_by_path_id(record.path_id).level
    record.parameter = "" if record.parameter.nil?
    record.from = DateTime.now if record.from.nil?
    record.until = DateTime.new(3000,1,1,0,0,0) if record.until.nil?
  end


  before_destroy do |record| #delete all related objects
    record.checks.destroy_all
    #record.page_properties.properties.destroy_all
    #record.page_properties.destroy_all
  end

end
