# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Stati

a = Account.create(name: "Sabines first account", active: true)
a.users.create(user_name: "Sabine", email: "sabine.mustermann@evil.orgs", first_name: "Sabine", last_name:"Mustermann", active: true, account_admin: true, super_admin: false)

a = Account.create(name: "Maxs first account", active: true)
a.users.create(user_name: "Max", email: "max.mustermann@evil.orgs", first_name: "Max", last_name:"Mustermann", active: true, account_admin: true, super_admin: true)

unless PropertyGroup.exists?(name: "Status")
  pg = PropertyGroup.create(name: "Status", description: "Describes the status of a domain or page.", active: true)
  pg.properties.create(name: "New",           value: 0,  sort_order: 1)
  pg.properties.create(name: "Unknown",       value: 1,  sort_order: 2)
  pg.properties.create(name: "Maintenance",   value: 2,  sort_order: 3)
  pg.properties.create(name: "Warning",       value: 3,  sort_order: 4)
  pg.properties.create(name: "Critical",      value: 4,  sort_order: 5)
  pg.properties.create(name: "OK",            value: 5,  sort_order: 6)
end

# Time intervals
unless PropertyGroup.exists?(name: "Interval")
  pg = PropertyGroup.create(name: "Interval", description: "Time period between checks", active: true)
  pg.properties.create(name: "don't",   value: 0,          sort_order: 0)
  pg.properties.create(name: "5 sec",   value: 5,          sort_order: 1)
  pg.properties.create(name: "10 sec",  value: 10,         sort_order: 2)
  pg.properties.create(name: "20 sec",  value: 20,         sort_order: 3)
  pg.properties.create(name: "30 sec",  value: 30,         sort_order: 4)
  pg.properties.create(name: "1 min",   value: 60,         sort_order: 5)
  pg.properties.create(name: "5 min",   value: 300,        sort_order: 6)
  pg.properties.create(name: "10 min",  value: 600,        sort_order: 7)
  pg.properties.create(name: "20 min",  value: 1200,       sort_order: 8)
  pg.properties.create(name: "30 min",  value: 1800,       sort_order: 9)
  pg.properties.create(name: "1 h",     value: 3600,       sort_order: 10)
  pg.properties.create(name: "2 h",     value: 7200,       sort_order: 11)
  pg.properties.create(name: "5 h",     value: 18000,      sort_order: 12)
  pg.properties.create(name: "10 h",    value: 36000,      sort_order: 13)
  pg.properties.create(name: "12 h",    value: 43200,      sort_order: 14)
  pg.properties.create(name: "1 day",   value: 86400,      sort_order: 15)
  pg.properties.create(name: "7 days",  value: 604800,     sort_order: 16)
  pg.properties.create(name: "14 days", value: 1209600,    sort_order: 17)
end

# Filter Types
unless PropertyGroup.exists?(name: "Filter type")
  pg = PropertyGroup.create(name: "Filter type", description: "Type of filter to match area with url", active: true)
  pg.properties.create(name: "Starts with",         value: 0,       sort_order: 0)
  pg.properties.create(name: "Contains",            value: 1,       sort_order: 1)
  pg.properties.create(name: "Regular expression",  value: 2,       sort_order: 2)
end

# Action Types
unless PropertyGroup.exists?(name: "Action type")
  pg = PropertyGroup.create(name: "Action type", description: "Type of action used on url, page, domain...", active: true)
  pg.properties.create(name: "Inactivate account",    value: 12,      sort_order: 1)
  pg.properties.create(name: "Activate account",      value: 13,      sort_order: 2)
  pg.properties.create(name: "Delete account",        value: 14,      sort_order: 3)
  pg.properties.create(name: "Inactivate user",       value: 22,      sort_order: 4)
  pg.properties.create(name: "Activate user",         value: 23,      sort_order: 5)
  pg.properties.create(name: "Delete user",           value: 24,      sort_order: 6)
  pg.properties.create(name: "Initial domain check",  value: 31,      sort_order: 7)
  pg.properties.create(name: "Inactivate domain",     value: 32,      sort_order: 8)
  pg.properties.create(name: "Activate domain",       value: 33,      sort_order: 9)
  pg.properties.create(name: "Delete domain",         value: 34,      sort_order: 10)
  pg.properties.create(name: "Initial page check",    value: 41,      sort_order: 11)
  pg.properties.create(name: "Inactivate page",       value: 42,      sort_order: 12)
  pg.properties.create(name: "Activate page",         value: 43,      sort_order: 13)
  pg.properties.create(name: "Delete page",           value: 14,      sort_order: 14)
  pg.properties.create(name: "Page Head only",        value: 101,     sort_order: 15)
  pg.properties.create(name: "Page exists",           value: 102,     sort_order: 16)
  pg.properties.create(name: "Publish time",          value: 103,     sort_order: 17)
end

one_day = Property.joins(:property_group).where(property_groups: {name: "Interval"}).where(properties: {name: "1 day"}).first
starts_with = Property.joins(:property_group).where(property_groups: {name: "Filter type"}).where(properties: {name: "Starts with"}).first


@domain = Domain.where(name: "Trelleborg Sealing Sollutions").first_or_initialize
if @domain.new_record?
  @domain.account_id              = a.id
  @domain.name                    = "Trelleborg Sealing Sollutions"
  @domain.domain                  = "www.tss.trelleborg.com"
  @domain.main_container          = "content"
  @domain.navigation_container    = "navigation-area"
  @domain.subnavigation_container = "leftnavi"
  @domain.save

  @domain.pages.create(path: "/global/en/homepage/homepage.html", title: "Hydraulic Seals, Rotary Shaft Seals, O-Rings by Trelleborg", active: true)
  @domain.pages.create(path: "/global/en/industries/industries.html", title: "Industry Specific Solutions: Aerospace, Automotive, Marine, Food", active: true)
  @domain.pages.create(path: "/global/en/industries/automotive/automotive.html", title: "Automotive Sealing Products, Seals & Gaskets: Automotive Industry", active: true)
  @domain.pages.create(path: "/global/en/company/facts_1/tss-facts.html", title: "TSS Company Facts Company Profile  - Trelleborg", active: true)
  @domain.pages.create(path: "/global/en/products_2/productrange.html", title: "", active: true)
  @domain.pages.create(path: "/global/en/industries/industries.html", title: "", active: true)
  @domain.pages.create(path: "/global/en/news_1/newsoverview/newsoverview.html", title: "", active: true)
  @domain.pages.create(path: "/global/en/service/service.html", title: "", active: true)
  @domain.pages.create(path: "/global/en/contact_1/contactform/contact-form.html", title: "", active: true)
  @domain.pages.create(path: "/global/en/company/manufacturingcapabilities/index.html", title: "", active: true)
  @domain.pages.create(path: "/global/en/company/manufacturingcapabilities/engineeredplastics/oringenergizedptfeseals/tsshelsingrdenmark/tss-helsingoer-denmark.html", title: "", active: true)
  @domain.pages.create(path: "/global/en/company/manufacturingcapabilities/engineeredplastics/bushingsandbearings/tssstreamwoodusa/tss-streamwood-usa.html", title: "", active: true)
  @domain.pages.create(path: "/global/en/news_1/newsarchive/archive2010/archiveoverview-2010.html", title: "", active: true)
  @domain.pages.create(path: "/global/en/products_2/orings_2/o-ring.html", title: "", active: true)
  @domain.pages.create(path: "/global/en/products_2/siliconetubingandhose/silicone-tubing-and-hose.html", title: "", active: true)

  @domain.areas.create(domain_id: @domain.id, name: "complete site", filter: "/", filter_type_property_id: starts_with.id, interval_property_id: one_day.id)
end

@domain = Domain.where(name: "Trelleborg group").first_or_initialize
if @domain.new_record?
  @domain.account_id = a.id
  @domain.name = "Trelleborg group"
  @domain.domain = "www.trelleborg.com"
  @domain.save
end

@domain = Domain.where(name: "Schittenhelm private homepage").first_or_initialize
if @domain.new_record?
  @domain.account_id = a.id
  @domain.name = "Schittenhelm private homepage"
  @domain.domain = "www.schittenhelm.de"
  @domain.save
end

@domain = Domain.where(name: "VHS Herrenberg").first_or_initialize
if @domain.new_record?
  @domain.account_id = a.id
  @domain.name = "VHS Herrenberg"
  @domain.domain = "www.vhs.herrenberg.de"
  @domain.save
  @domain.pages.create(path: "/kursliste/147", title: "", active: true)
  @domain.pages.create(path: "/kursliste/143", title: "", active: true)
  @domain.pages.create(path: "/kultur-kunst-gestalten-musik/informationen", title: "", active: true)
end