# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Stati

print "start =========================================================\n"

print "creating accounts =============================================\n"
print "Sabine\n"
a = Account.create(name: "Sabines first account", active: true)
a.users.create(user_name: "Sabine", email: "sabine.mustermann@evil.orgs", first_name: "Sabine", last_name:"Mustermann", active: true, account_admin: true, super_admin: false)

print "Max\n"
a = Account.create(name: "Maxs first account", active: true)
a.users.create(user_name: "Max", email: "max.mustermann@evil.orgs", first_name: "Max", last_name:"Mustermann", active: true, account_admin: true, super_admin: true)

print "creating property groups ======================================\n"
unless PropertyGroup.exists?(name: "Status")
  pg = PropertyGroup.create(name: "Status", description: "Describes the status of a domain or page.", active: true)
  pg.properties.create(name: "New",           value: 0)
  pg.properties.create(name: "Unknown",       value: 1)
  pg.properties.create(name: "Maintenance",   value: 2)
  pg.properties.create(name: "Warning",       value: 3)
  pg.properties.create(name: "Critical",      value: 4)
  pg.properties.create(name: "OK",            value: 5)
end

print "creating properties============================================\n"
print "Time intevals\n"
unless PropertyGroup.exists?(name: "Interval")
  pg = PropertyGroup.create(name: "Interval", description: "Time period between checks", active: true)
  pg.properties.create(name: "don't",   value: 0)
  pg.properties.create(name: "5 sec",   value: 5)
  pg.properties.create(name: "10 sec",  value: 10)
  pg.properties.create(name: "20 sec",  value: 20)
  pg.properties.create(name: "30 sec",  value: 30)
  pg.properties.create(name: "1 min",   value: 60)
  pg.properties.create(name: "5 min",   value: 300)
  pg.properties.create(name: "10 min",  value: 600)
  pg.properties.create(name: "20 min",  value: 1200)
  pg.properties.create(name: "30 min",  value: 1800)
  pg.properties.create(name: "1 h",     value: 3600)
  pg.properties.create(name: "2 h",     value: 7200)
  pg.properties.create(name: "5 h",     value: 18000)
  pg.properties.create(name: "10 h",    value: 36000)
  pg.properties.create(name: "12 h",    value: 43200)
  pg.properties.create(name: "1 day",   value: 86400)
  pg.properties.create(name: "7 days",  value: 604800)
  pg.properties.create(name: "14 days", value: 1209600)
end

print "Filter types\n"
unless PropertyGroup.exists?(name: "Filter type")
  pg = PropertyGroup.create(name: "Filter type", description: "Type of filter to match area with url", active: true)
  pg.properties.create(name: "Starts with",         value: 0)
  pg.properties.create(name: "Contains",            value: 1)
  pg.properties.create(name: "Regular expression",  value: 2)
end

print "Action types\n"
unless PropertyGroup.exists?(name: "Action type")
  pg = PropertyGroup.create(name: "Action type", description: "Type of action used on url, page, domain...", active: true)
  pg.properties.create(name: "Inactivate account",    value: 12)
  pg.properties.create(name: "Activate account",      value: 13)
  pg.properties.create(name: "Delete account",        value: 14)
  pg.properties.create(name: "Inactivate user",       value: 22)
  pg.properties.create(name: "Activate user",         value: 23)
  pg.properties.create(name: "Delete user",           value: 24)
  pg.properties.create(name: "Initial domain check",  value: 31)
  pg.properties.create(name: "Inactivate domain",     value: 32)
  pg.properties.create(name: "Activate domain",       value: 33)
  pg.properties.create(name: "Delete domain",         value: 34)
  pg.properties.create(name: "Initial page check",    value: 41)
  pg.properties.create(name: "Inactivate page",       value: 42)
  pg.properties.create(name: "Activate page",         value: 43)
  pg.properties.create(name: "Delete page",           value: 14)
  pg.properties.create(name: "Do all possible checks",value: 100)
  pg.properties.create(name: "Check Page Head only",  value: 101)
  pg.properties.create(name: "Check Page exists",     value: 102)
  pg.properties.create(name: "Check content changes", value: 103)
  pg.properties.create(name: "Check Publish time",    value: 104)
end

print "Image file type\n"
unless PropertyGroup.exists?(name: "Image file type")
  pg = PropertyGroup.create(name: "Image file type", description: "File extension of image files", active: true)
  pg.properties.create(name: "Joint Photographic Experts Group",    value: "jpg")
  pg.properties.create(name: "Joint Photographic Experts Group",    value: "jpeg")
  pg.properties.create(name: "Tagged Image File Format",            value: "tif")
  pg.properties.create(name: "Tagged Image File Format",            value: "tiff")
  pg.properties.create(name: "Windows bitmap",                      value: "bmp")
  pg.properties.create(name: "Portable Network Graphics",           value: "png")
  pg.properties.create(name: "WebP",                                value: "webp")
  pg.properties.create(name: "TARGA",                               value: "targa")
  pg.properties.create(name: "Thumbnail Image File",                value: "thm")
  pg.properties.create(name: "Image file",                          value: "img")
  pg.properties.create(name: "Adobe PhotoShop Document",            value: "psd")
  pg.properties.create(name: "Paint Shop Pro",                      value: "psp")
  pg.properties.create(name: "Adobe Illustrator File",              value: "ai")
  pg.properties.create(name: "Encapsulated PostScript File",        value: "eps")
  pg.properties.create(name: "PostScript File",                     value: "ps")
  pg.properties.create(name: "Scalable Vector Graphics File",       value: "svg")
  pg.properties.create(name: "JPEG Stereo",                         value: "jps")
  pg.properties.create(name: "PNG Stereo",                          value: "pns")
end

print "Document / Application file type\n"
unless PropertyGroup.exists?(name: "Document / Application file type")
  pg.properties.create(name: "Plain Text File",                      value: "txt")
  pg.properties.create(name: "ASCII text file",                      value: "asc")
  pg.properties.create(name: "Readme Text File",                     value: "readme")
  pg.properties.create(name: "XML File",                             value: "xml")
  pg.properties.create(name: "Log file",                             value: "log")
  pg.properties.create(name: "Rich Text Format File",                value: "rtf")
  pg.properties.create(name: "Microsoft Word Document",              value: "doc")
  pg.properties.create(name: "Microsoft Word Open XML Document",     value: "docx")
  pg.properties.create(name: "Microsoft Word Document Template",     value: "dot")
  pg.properties.create(name: "Microsoft Word Open XML Template",     value: "dotx")
  pg.properties.create(name: "OpenOffice/StarOffice OpenDocument",   value: "odt")
  pg.properties.create(name: "OpenDocument Text Document Template",  value: "ott")
  pg.properties.create(name: "PowerPoint Slide Show",                value: "pps")
  pg.properties.create(name: "PowerPoint Presentation",              value: "ppt")
  pg.properties.create(name: "PowerPoint Open XML Presentation",     value: "pptx")
  pg.properties.create(name: "LaTeX Source",                         value: "tex")
  pg.properties.create(name: "Comma Separated Value Data File",      value: "csv")
  pg.properties.create(name: "Microsoft Works Spreadsheet File",     value: "xlr")
  pg.properties.create(name: "Microsoft Excel Spreadsheet File",     value: "xls")
  pg.properties.create(name: "Microsoft Office Excel (2007+) Non-XML Binary Spreadsheet", value: "xlsb")
  pg.properties.create(name: "Microsoft Office Excel (2007+) Spreadsheet(Macro Enabled)", value: "xlsm")
  pg.properties.create(name: "Microsoft Office Excel (2007+) Spreadsheet",                value: "xlsx")
  pg.properties.create(name: "Microsoft Office Excel (2007+) Template (Macro Enabled)",   value: "xltm")
  pg.properties.create(name: "Microsoft Office Excel (2007+) Template",                   value: "xltx")
end

print "Multimedia file type\n"
unless PropertyGroup.exists?(name: "Multimedia file type")
  pg.properties.create(name: "Advanced Audio Coding File",           value: "aac")
  pg.properties.create(name: "Dolby 5.1 Channel Sound Format",       value: "ac3")
  pg.properties.create(name: "Audio Interchange File",               value: "aif")
  pg.properties.create(name: "Audio Interchange File",               value: "aiff")
  pg.properties.create(name: "Monkeys Audio File",                   value: "ape")
  pg.properties.create(name: "Free Lossless Audio Codec File",       value: "flac")
  pg.properties.create(name: "Audio stream Raw GSM",                 value: "gsm")
  pg.properties.create(name: "Interchange File Format",              value: "iff")
  pg.properties.create(name: "MPEG-4 Audio Layer",                   value: "m4a")
  pg.properties.create(name: "MPEG-4 Audio Book File",               value: "m4b")
  pg.properties.create(name: "iTunes Audio Format",                  value: "m4p")
  pg.properties.create(name: "Apple iPhone Ringtone File",           value: "m4r")
  pg.properties.create(name: "Musical Instrument Digital Interface (MIDI) Sound File",  value: "mid")
  pg.properties.create(name: "Musical Instrument Digital Interface (MIDI) Sound File",  value: "midi")
  pg.properties.create(name: "MPEG Audio Stream",                    value: "mp2")
  pg.properties.create(name: "MP3 Audio File",                       value: "mp3")
  pg.properties.create(name: "MPEG Audio Stream",                    value: "mpa")
  pg.properties.create(name: "Musepack Audio File",                  value: "mpc")
  pg.properties.create(name: "Ogg Vorbis Audio",                     value: "oga")
  pg.properties.create(name: "Ogg Vorbis Codec Compressed WAV File", value: "ogg")
  pg.properties.create(name: "Waveform Audio",                       value: "wav")
  pg.properties.create(name: "Windows Media Audio File",             value: "wma")
  pg.properties.create(name: "Audio Video Interleave File",          value: "avi")
  pg.properties.create(name: "DivX Video File",                      value: "divx")
  pg.properties.create(name: "DivX Video File",                      value: "dvx")
  pg.properties.create(name: "Digital Video Recorder File",          value: "dvr")
  pg.properties.create(name: "Flash Video File",                     value: "flv")
  pg.properties.create(name: "Matroska Video Stream",                value: "mkv")
  pg.properties.create(name: "MJPEG Video File",                     value: "mjp")
  pg.properties.create(name: "QuickTime for Windows Movie",          value: "mov")
  pg.properties.create(name: "MPEG 4 Video File",                    value: "mp4")
  pg.properties.create(name: "MPEG Movie",                           value: "mpeg")
  pg.properties.create(name: "MPEG Video File",                      value: "mpg")
  pg.properties.create(name: "MPEG-2 Video",                         value: "mpg2")
  pg.properties.create(name: "Ogg Vorbis Video",                     value: "ogv")
  pg.properties.create(name: "OGG Vorbis Multiplexed Media File",    value: "ogx")
  pg.properties.create(name: "Shockwave Flash Object",               value: "swf")
  pg.properties.create(name: "DVD Video Object File",                value: "vob")
  pg.properties.create(name: "XVID Encoded Video File",              value: "xvid")
end


one_day = Property.joins(:property_group).where(property_groups: {name: "Interval"}).where(properties: {name: "1 day"}).first
starts_with = Property.joins(:property_group).where(property_groups: {name: "Filter type"}).where(properties: {name: "Starts with"}).first

print "creating domains ==============================================\n"
print "Trelleborg Sealing Solutions\n"
@domain = Domain.where(name: "Trelleborg Sealing Solutions").first_or_initialize
if @domain.new_record?
  @domain.account_id                = a.id
  @domain.name                      = "Trelleborg Sealing Solutions"
  @domain.domain                    = "www.tss.trelleborg.com"
  @domain.check_content_for_changes = true
  @domain.save

  print "areas\n"
  @domain.areas.create(name: "complete site", filter: "/", filter_type_property_id: starts_with.id, interval_property_id: one_day.id)

  print "containers\n"
  @domain.containers.create(name: "Main content", x_path:'//*[@id="content-home"]\r\n//*[@id="content"]')
  @domain.containers.create(name: "Top navigation", x_path:'//*[@id="navigation-area"]',ignore:true)
  @domain.containers.create(name: "Left navigation", x_path:'//*[@id="leftnavi"]',ignore:true)

  print "pages\n"
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
end

print "Trelleborg group\n"
@domain = Domain.where(name: "Trelleborg group").first_or_initialize
if @domain.new_record?
  @domain.account_id                = a.id
  @domain.name                      = "Trelleborg group"
  @domain.domain                    = "www.trelleborg.com"
  @domain.check_content_for_changes = true
  @domain.save

  print "containers\n"
  @domain.containers.create(name: "Main content", x_path:"//*[@id=\"subpage\"]")
  @domain.containers.create(name: "Top navigation", x_path:"//*[@id=\"topmenu\"]",ignore:true)
  @domain.containers.create(name: "Left navigation", x_path:"//*[@id=\"leftmenu\"]",ignore:true)
end

print "Orkot Marine Bearings\n"
@domain = Domain.where(name: "Orkot Marine Bearings").first_or_initialize
if @domain.new_record?
  @domain.account_id                = a.id
  @domain.name                      = "Orkot Marine Bearings"
  @domain.domain                    = "http://www.orkotmarine.com"
  @domain.check_content_for_changes = true
  @domain.save

  print "areas\n"
  @domain.areas.create(name: "complete site", filter: "/", filter_type_property_id: starts_with.id, interval_property_id: one_day.id)

  print "containers\n"
  @domain.containers.create(name: "Main content", x_path:'/html/body/table')
  @domain.containers.create(name: "Top navigation", x_path:'//*[@id="menu0"]',ignore:true)
end

print "Orkot Hydro Bearings\n"
@domain = Domain.where(name: "Orkot Hydro Bearings").first_or_initialize
if @domain.new_record?
  @domain.account_id                = a.id
  @domain.name                      = "Orkot Marine Bearings"
  @domain.domain                    = "http://www.orkothydro.com"
  @domain.check_content_for_changes = true
  @domain.save

  print "areas\n"
  @domain.areas.create(name: "complete site", filter: "/", filter_type_property_id: starts_with.id, interval_property_id: one_day.id)

  print "containers\n"
  @domain.containers.create(name: "Main content", x_path:'/html/body/table')
  @domain.containers.create(name: "Top navigation", x_path:'//*[@id="menu0"]',ignore:true)
end


print "Schittenhelm\n"
@domain = Domain.where(name: "Schittenhelm private homepage").first_or_initialize
if @domain.new_record?
  @domain.account_id                = a.id
  @domain.name                      = "Schittenhelm private homepage"
  @domain.domain                    = "www.schittenhelm.de"
  @domain.check_content_for_changes = true
  @domain.main_container            = "//*[@id=\"main\"]"
  @domain.navigation_container      = "//*[@id=\"navigation\"]"
  @domain.save
end

print "Stihl\n"
@domain = Domain.where(name: "Stihl").first_or_initialize
if @domain.new_record?
  @domain.account_id                = a.id
  @domain.name                      = "Stihl"
  @domain.domain                    = "www.stihl.de"
  @domain.check_content_for_changes = true
  @domain.main_container            = "//*[@id=\"main_content\"]/div[2]"
  @domain.navigation_container      = "//*[@id=\"navigation\"]"
  @domain.subnavigation_container   = "//*[@id=\"left_navigation\"]"
  @domain.save
end

print "SFE\n"
@domain = Domain.where(name: "SFE").first_or_initialize
if @domain.new_record?
  @domain.account_id                = a.id
  @domain.name                      = "SFE"
  @domain.domain                    = "www.sfe.de"
  @domain.check_content_for_changes = true
  @domain.main_container            = "//*[@id='ctl4']"
  @domain.navigation_container      = "//*[@id='main-nav']"
  @domain.subnavigation_container   = "//*[@id='ctl12']"
  @domain.save
end


print "VHS Herrenberg\n"
@domain = Domain.where(name: "VHS Herrenberg").first_or_initialize
if @domain.new_record?
  @domain.account_id                = a.id
  @domain.name                      = "VHS Herrenberg"
  @domain.domain                    = "www.vhs.herrenberg.de"
  @domain.check_content_for_changes = true
  @domain.main_container            = "//*[@id=\"main\"]"
  @domain.navigation_container      = "//*[@id=\"primary\"]"
  @domain.subnavigation_container   = "//*[@id=\"block-menu-menu-departments\"]"
  @domain.save
  @domain.save
  @domain.pages.create(path: "/kursliste/147", title: "", active: true)
  @domain.pages.create(path: "/kursliste/143", title: "", active: true)
  @domain.pages.create(path: "/kultur-kunst-gestalten-musik/informationen", title: "", active: true)
end

print "Heise\n"
@domain = Domain.where(name: "Heise").first_or_initialize
if @domain.new_record?
  @domain.account_id                = a.id
  @domain.name                      = "Heise"
  @domain.domain                    = "www.heise.de"
  @domain.check_content_for_changes = false
  @domain.main_container            = "//div[@class='meldung_wrapper']\r//*[@id='artikel_shortnews']\r//*[@id='bildergalerie']\r//*[@id='mitte_artikel']"
  @domain.navigation_container      = "//*[@id='heisetopnavi_sub_container']"
  @domain.subnavigation_container   = "//*[@id='mitte_rechts']"
  @domain.save
end
