class Domain < ActiveRecord::Base
  attr_accessible :account_id, :name, :description, :scheme, :domain, :port, :status,
                  :check_page_rank, :check_page_speed, :check_y_slow, :check_content_for_changes,
                  :check_publish_time, :regx_publish_time,
                  :active, :row_order, :pages

  has_many    :pages
  has_many    :areas
  has_many    :containers
  belongs_to  :account

  validates :name,    :presence => true
  validates :domain,  :presence => true
  validates :scheme,  :inclusion => { :in => %w(http https),
                                      :message => "%{value} is not a valid. Allowed are http or https" }, :allow_blank => true
  validates :port, :numericality => { :only_integer => true,
                                      :greater_than_or_equal_to => 1,
                                      :less_than_or_equal_to => 65536 } ,:allow_blank => true
  validates :regx_publish_time, :presence => { :if => :check_publish_time?,
                                               :message => "When you want to check publish times you must define a selector for the publishing time." }

  validates :regx_publish_time, :format => {:if => :regx_publish_time?,
                                            :with => /(\?(<day>|<month>|<year>|<hour>|<min>|<sec>).*?){6}/i,
                                            :message => "The regular expression needs to have named selectors for; day,month,year,hour,min and sec." }
  validates :uuid, :presence => true, :uniqueness => true

  include RankedModel
  ranks :row_order

  after_initialize do |record|
    #record.status = 0
  end

  before_destroy do |record| #delete all related objects
    record.pages.destroy_all
    record.areas.destroy_all
  end

  before_validation(:on => :create) do
    self.uuid = UUIDTools::UUID.random_create.to_s
  end

  before_save do |record|
    if record.scheme.nil? or record.scheme.empty?
      record.scheme="http"
    end
    record.domain = record.domain.downcase
  end

  after_create do |record| # create default page
    record.status = 0
    record.save
    path_id = WebPageAnalyser.get_path_id(record.id,"/")
    record.pages.create(path_id: path_id , title: "Homepage")
    record.areas.create(name: "root only",
                        filter: "^/*$",
                        interval_property_id: Property.joins(:property_group).where(property_groups: {code: "interval"}).where(properties: {code: "1_h"}).first.id,
                        filter_type_property_id: Property.joins(:property_group).where(property_groups: {code: "filter_type"}).where(properties: {code: "regular_expression"}).first.id)
    record.areas.create(name: "match all",
                        filter: "/",
                        interval_property_id: Property.joins(:property_group).where(property_groups: {code: "interval"}).where(properties: {code: "1_day"}).first.id,
                        filter_type_property_id: Property.joins(:property_group).where(property_groups: {code: "filter_type"}).where(properties: {code: "starts_with"}).first.id)
  end
end
