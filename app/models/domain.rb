class Domain < ActiveRecord::Base
  attr_accessible :account_id, :name, :description, :scheme, :domain, :port,
                  :checkPageRank, :checkPageSpeed, :checkYSlow,:checkContentForChanges,
                  :mainContainer, :navigationContainer, :subnavigationContainer, :ignoreContainer,
                  :checkPublishTime, :regxPublishTime,
                  :active, :sortorder, :pages
  has_many :pages
  belongs_to :accounts

  validates :name, :presence => true
  validates :domain, :presence => true
  validates_associated :pages

  after_initialize do |record|
    record.active = true
    #record.status = 0
  end
  before_destroy do |record| #delete all related objects
    record.pages.destroy_all
  end
  before_save do |record|
    record.domain = record.path.domain
  end
  after_create do |record| # create default page
    record.pages.create(path: "/")
  end

end
