class Page < ActiveRecord::Base
  attr_accessible :domain_id, :path, :title, :active, :status,
                  :pageRank, :pageSpeed, :ySlow,
                  :checkCounter, :lastCheck, :actContent

  belongs_to :domain
  has_many :properties, :through => :url_properties

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

end
