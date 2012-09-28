class Domain < ActiveRecord::Base
  attr_accessible :account_id, :name, :description, :scheme, :domain, :port,
                  :check_page_rank, :check_page_speed, :check_y_slow, :check_content_for_changes,
                  :main_container, :navigation_container, :subnavigation_container, :ignore_container,
                  :check_publish_time, :regx_publish_time,
                  :active, :sort_order, :pages

  has_many    :pages
  has_many    :areas
  belongs_to  :account

  validates :name,    :presence => true
  validates :domain,  :presence => true
  validates :scheme,  :inclusion => { :in => %w(http https),
                                      :message => "%{value} is not a valid. Allowed are http or https" }, :allow_blank => true
  validates :port, :numericality => { :only_integer => true,
                                      :greater_than_or_equal_to => 1,
                                      :less_than_or_equal_to => 65536 } ,:allow_blank => true
  validates :main_container, :presence => { :if => :check_content_for_changes?,
                                            :message => "When you want to check content changes you must define the id of the content container."}
  validates :regx_publish_time, :presence => { :if => :check_publish_time?,
                                               :message => "When you want to check publish times you must define a selector for the publishing time." }

  after_initialize do |record|
    #record.status = 0
  end

  before_destroy do |record| #delete all related objects
    record.pages.destroy_all
    record.areas.destroy_all
  end

  before_save do |record|
    if record.scheme.nil? or record.scheme.empty?
      record.scheme="http"
    end
    record.domain = record.domain.downcase
  end

  after_create do |record| # create default page
    record.pages.create(path: "/", title: "Homepage")
    record.areas.create(name: "root only",
                        filter: "^/*$",
                        interval_property_id: Property.joins(:property_group).where(property_groups: {name: "Interval"}).where(properties: {name: "1 h"}).first,
                        filter_type_property_id: Property.joins(:property_group).where(property_groups: {name: "Filter type"}).where(properties: {name: "Regular expression"}).first)
    record.areas.create(name: "match all",
                        filter: "/",
                        interval_property_id: Property.joins(:property_group).where(property_groups: {name: "Interval"}).where(properties: {name: "1 day"}).first,
                        filter_type_property_id: Property.joins(:property_group).where(property_groups: {name: "Filter type"}).where(properties: {name: "Starts with"}).first)
  end

end
