# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Stati

@a = Account.create(name: "Sabines first account", active: true)
@a.users.create(username: "Sabine", email: "sabine.mustermann@evil.orgs", firstName: "Sabine", lastName:"Mustermann", active: true, accountAdmin: true, superAdmin: false)

@a = Account.create(name: "Maxs first account", active: true)
@a.users.create(username: "Max", email: "max.mustermann@evil.orgs", firstName: "Max", lastName:"Mustermann", active: true, accountAdmin: true, superAdmin: true)

if !PropertyGroup.exists?(name: "Status")
  pg = PropertyGroup.create(name: "Status", description: "Describes the status of a domain or page.", active: true)
  pg.properties.create(name: "New",           value: 0,  sortorder: 1)
  pg.properties.create(name: "Unknown",       value: 1,  sortorder: 2)
  pg.properties.create(name: "Maintainance",  value: 2,  sortorder: 3)
  pg.properties.create(name: "Warning",       value: 3,  sortorder: 4)
  pg.properties.create(name: "Critical",      value: 4,  sortorder: 5)
  pg.properties.create(name: "OK",            value: 5,  sortorder: 6)
end

# Time intervals
if !PropertyGroup.exists?(name: "Interval")
  pg = PropertyGroup.create(name: "Interval", description: "Time period between checks", active: true)
  pg.properties.create(name: "5 sec",   value: 5,          sortorder: 1)
  pg.properties.create(name: "10 sec",  value: 10,         sortorder: 2)
  pg.properties.create(name: "20 sec",  value: 20,         sortorder: 3)
  pg.properties.create(name: "30 sec",  value: 30,         sortorder: 4)
  pg.properties.create(name: "1 min",   value: 60,         sortorder: 5)
  pg.properties.create(name: "5 min",   value: 300,        sortorder: 6)
  pg.properties.create(name: "10 min",  value: 600,        sortorder: 7)
  pg.properties.create(name: "20 min",  value: 1200,       sortorder: 8)
  pg.properties.create(name: "30 min",  value: 1800,       sortorder: 9)
  pg.properties.create(name: "1 h",     value: 3600,       sortorder: 10)
  pg.properties.create(name: "2 h",     value: 7200,       sortorder: 11)
  pg.properties.create(name: "5 h",     value: 18000,      sortorder: 12)
  pg.properties.create(name: "10 h",    value: 36000,      sortorder: 13)
  pg.properties.create(name: "12 h",    value: 43200,      sortorder: 14)
  pg.properties.create(name: "1 day",   value: 86400,      sortorder: 15)
  pg.properties.create(name: "7 days",  value: 604800,     sortorder: 16)
  pg.properties.create(name: "14 days", value: 1209600,    sortorder: 17)
end

@domain = Domain.where(name: "Trelleborg Sealing Sollutions").first_or_initialize
if @domain.new_record?
  @domain.account_id              = @a.id
  @domain.name                    = "Trelleborg Sealing Sollutions"
  @domain.domain                  = "www.tss.trelleborg.com"
  @domain.mainContainer           = "content"
  @domain.navigationContainer     = "navigation-area"
  @domain.subnavigationContainer  = "leftnavi"
  @domain.save

  @domain.pages.create(path: "/global/en/homepage/homepage.html", title: "Hydraulic Seals, Rotary Shaft Seals, O-Rings by Trelleborg", active: true)
  @domain.pages.create(path: "/global/en/industries/industries.html", title: "Industry Specific Solutions: Aerospace, Automotive, Marine, Food", active: true)
  @domain.pages.create(path: "/global/en/industries/automotive/automotive.html", title: "Automotive Sealing Products, Seals & Gaskets: Automotive Industry", active: true)
  @domain.pages.create(path: "/global/en/company/facts_1/tss-facts.html", title: "TSS Company Facts Company Profile  - Trelleborg", active: true)
  @domain.pages.create(path: "/global/en/products_2/productrange.html", title: "", active: true)
  @domain.pages.create(path: "/global/en/industries/industries.html", title: "", active: true)
  @domain.pages.create(path: "/global/en/news_1/newsoverview/newsoverview.html", title: "", active: true)
end

@domain = Domain.where(name: "Trelleborg group").first_or_initialize
if @domain.new_record?
  @domain.account_id = @a.id
  @domain.name = "Trelleborg group"
  @domain.domain = "www.trelleborg.com"
  @domain.save
end