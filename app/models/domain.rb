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
  validates :scheme, :inclusion => { :in => %w(http https),
                                      :message => "%{value} is not a valid. Allowed are http or https" }, :allow_blank => true
  validates :port, :numericality => { :only_integer => true,
                                         :greater_than_or_equal_to => 1,
                                         :less_than_or_equal_to => 65536 } ,:allow_blank => true
  validates :mainContainer, :presence => { :if => :checkContentForChanges?,
                                           :message => "When you want to check content changes you must define the id of the content container."}
  validates :regxPublishTime, :presence => { :if => :checkPublishTime?,
                                             :message => "When you want to check publish times you must define a selector for the publishing time." }

  #validates_associated :pages

  after_initialize do |record|
    record.active = true
    #record.status = 0
  end
  before_destroy do |record| #delete all related objects
    record.pages.destroy_all
  end
  before_save do |record|
    if record.scheme.nil? or record.scheme.empty?
      record.scheme="http"
    end

    record.domain = record.domain.downcase
  end
  after_create do |record| # create default page
    record.pages.create(path: "/")
  end

end
