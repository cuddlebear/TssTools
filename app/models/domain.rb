class Domain < ActiveRecord::Base
  attr_accessible :description, :name, :path, :urls
  has_many :urls
  validates :name, :presence => true
  validates :path, :presence => true
  validates_associated :urls

  before_destroy do |domain| #delete all related objects
    domain.urls.destroy_all
  end
  before_save do |domain|
    domain.path = domain.path.downcase
  end
  after_create do |domain| # create default url
    domain.urls.create(path: "http://" + path)
  end

end
