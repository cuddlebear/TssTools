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
  pg = PropertyGroup.create(name: "Status", description: "Describes the status of a domain or page.", active: true, type:"int")
  pg.properties.create(name: "New",           int_value: 0)
  pg.properties.create(name: "Unknown",       int_value: 1)
  pg.properties.create(name: "Maintenance",   int_value: 2)
  pg.properties.create(name: "Warning",       int_value: 3)
  pg.properties.create(name: "Critical",      int_value: 4)
  pg.properties.create(name: "OK",            int_value: 5)
end

print "creating properties============================================\n"
print "Time intevals\n"
unless PropertyGroup.exists?(name: "Interval")
  pg = PropertyGroup.create(name: "Interval", description: "Time period between checks", active: true, type:"int")
  pg.properties.create(name: "don't check",   int_value: 0)
  pg.properties.create(name: "5 sec",         int_value: 5)
  pg.properties.create(name: "10 sec",        int_value: 10)
  pg.properties.create(name: "20 sec",        int_value: 20)
  pg.properties.create(name: "30 sec",        int_value: 30)
  pg.properties.create(name: "1 min",         int_value: 60)
  pg.properties.create(name: "5 min",         int_value: 300)
  pg.properties.create(name: "10 min",        int_value: 600)
  pg.properties.create(name: "20 min",        int_value: 1200)
  pg.properties.create(name: "30 min",        int_value: 1800)
  pg.properties.create(name: "1 h",           int_value: 3600)
  pg.properties.create(name: "2 h",           int_value: 7200)
  pg.properties.create(name: "5 h",           int_value: 18000)
  pg.properties.create(name: "10 h",          int_value: 36000)
  pg.properties.create(name: "12 h",          int_value: 43200)
  pg.properties.create(name: "1 day",         int_value: 86400)
  pg.properties.create(name: "2 days",        int_value: 86400*2)
  pg.properties.create(name: "3 days",        int_value: 86400*4)
  pg.properties.create(name: "7 days",        int_value: 604800)
  pg.properties.create(name: "14 days",       int_value: 1209600)
end

print "Filter types\n"
unless PropertyGroup.exists?(name: "Filter type")
  pg = PropertyGroup.create(name: "Filter type", description: "Type of filter to match area with url", active: true, type:"int")
  pg.properties.create(name: "Starts with",         int_value: 0)
  pg.properties.create(name: "Contains",            int_value: 1)
  pg.properties.create(name: "Regular expression",  int_value: 2)
end

print "Content types\n"
unless PropertyGroup.exists?(name: "Content type")
  pg = PropertyGroup.create(name: "Content type", description: "Type of content which is assigned to the container", active: true, type:"int")
  pg.properties.create(name: "Main content",        int_value: 0)
  pg.properties.create(name: "Navigation",          int_value: 1)
  pg.properties.create(name: "Subnavigation",       int_value: 2)
  pg.properties.create(name: "Teaser",              int_value: 3)
  pg.properties.create(name: "Advertisement",       int_value: 4)
  pg.properties.create(name: "SEO",                 int_value: 5)
  pg.properties.create(name: "Other",               int_value: 6)
end

print "Action types\n"
unless PropertyGroup.exists?(name: "Action type")
  pg = PropertyGroup.create(name: "Action type", description: "Type of action used on url, page, domain...", active: true, type:"int")
  pg.properties.create(name: "Inactivate account",    int_value: 12)
  pg.properties.create(name: "Activate account",      int_value: 13)
  pg.properties.create(name: "Delete account",        int_value: 14)
  pg.properties.create(name: "Inactivate user",       int_value: 22)
  pg.properties.create(name: "Activate user",         int_value: 23)
  pg.properties.create(name: "Delete user",           int_value: 24)
  pg.properties.create(name: "Initial domain check",  int_value: 31)
  pg.properties.create(name: "Inactivate domain",     int_value: 32)
  pg.properties.create(name: "Activate domain",       int_value: 33)
  pg.properties.create(name: "Delete domain",         int_value: 34)
  pg.properties.create(name: "Initial page check",    int_value: 41)
  pg.properties.create(name: "Inactivate page",       int_value: 42)
  pg.properties.create(name: "Activate page",         int_value: 43)
  pg.properties.create(name: "Delete page",           int_value: 14)
  pg.properties.create(name: "Do all possible checks",int_value: 100)
  pg.properties.create(name: "Check Page Head only",  int_value: 101)
  pg.properties.create(name: "Check Page exists",     int_value: 102)
  pg.properties.create(name: "Check content changes", int_value: 103)
  pg.properties.create(name: "Check Publish time",    int_value: 104)
end

print "File extensions\n"
unless PropertyGroup.exists?(name: "File extensions")
  file_extensions = PropertyGroup.create(name: "File extensions", description: "File extension main group", active: true, type:"text")
end

print "Image file type\n"
unless PropertyGroup.exists?(name: "Image files")
  pg = PropertyGroup.create(name: "Image files", description: "File extension of image files", active: true, type:"text", property_group_id: file_extensions.id)
  pg.properties.create(name: "Joint Photographic Experts Group",    text_value: "jpg")
  pg.properties.create(name: "Joint Photographic Experts Group",    text_value: "jpeg")
  pg.properties.create(name: "Tagged Image File Format",            text_value: "tif")
  pg.properties.create(name: "Tagged Image File Format",            text_value: "tiff")
  pg.properties.create(name: "Windows bitmap",                      text_value: "bmp")
  pg.properties.create(name: "Portable Network Graphics",           text_value: "png")
  pg.properties.create(name: "WebP",                                text_value: "webp")
  pg.properties.create(name: "TARGA",                               text_value: "targa")
  pg.properties.create(name: "Thumbnail Image File",                text_value: "thm")
  pg.properties.create(name: "Image file",                          text_value: "img")
  pg.properties.create(name: "Adobe PhotoShop Document",            text_value: "psd")
  pg.properties.create(name: "Paint Shop Pro",                      text_value: "psp")
  pg.properties.create(name: "Adobe Illustrator File",              text_value: "ai")
  pg.properties.create(name: "Encapsulated PostScript File",        text_value: "eps")
  pg.properties.create(name: "PostScript File",                     text_value: "ps")
  pg.properties.create(name: "Scalable Vector Graphics File",       text_value: "svg")
  pg.properties.create(name: "JPEG Stereo",                         text_value: "jps")
  pg.properties.create(name: "PNG Stereo",                          text_value: "pns")
end

print "Document / Application files\n"
unless PropertyGroup.exists?(name: "Document / Application files")
  pg = PropertyGroup.create(name: "Document / Application files", description: "File extension of application files", active: true, type:"text", property_group_id: file_extensions.id)
  pg.properties.create(name: "Plain Text File",                      text_value: "txt")
  pg.properties.create(name: "ASCII text file",                      text_value: "asc")
  pg.properties.create(name: "Readme Text File",                     text_value: "readme")
  pg.properties.create(name: "XML File",                             text_value: "xml")
  pg.properties.create(name: "Log file",                             text_value: "log")
  pg.properties.create(name: "Rich Text Format File",                text_value: "rtf")
  pg.properties.create(name: "Microsoft Word Document",              text_value: "doc")
  pg.properties.create(name: "Microsoft Word Open XML Document",     text_value: "docx")
  pg.properties.create(name: "Microsoft Word Document Template",     text_value: "dot")
  pg.properties.create(name: "Microsoft Word Open XML Template",     text_value: "dotx")
  pg.properties.create(name: "OpenOffice/StarOffice OpenDocument",   text_value: "odt")
  pg.properties.create(name: "OpenDocument Text Document Template",  text_value: "ott")
  pg.properties.create(name: "PowerPoint Slide Show",                text_value: "pps")
  pg.properties.create(name: "PowerPoint Presentation",              text_value: "ppt")
  pg.properties.create(name: "PowerPoint Open XML Presentation",     text_value: "pptx")
  pg.properties.create(name: "LaTeX Source",                         text_value: "tex")
  pg.properties.create(name: "Comma Separated value Data File",      text_value: "csv")
  pg.properties.create(name: "Microsoft Works Spreadsheet File",     text_value: "xlr")
  pg.properties.create(name: "Microsoft Excel Spreadsheet File",     text_value: "xls")
  pg.properties.create(name: "Microsoft Office Excel (2007+) Non-XML Binary Spreadsheet", text_value: "xlsb")
  pg.properties.create(name: "Microsoft Office Excel (2007+) Spreadsheet(Macro Enabled)", text_value: "xlsm")
  pg.properties.create(name: "Microsoft Office Excel (2007+) Spreadsheet",                text_value: "xlsx")
  pg.properties.create(name: "Microsoft Office Excel (2007+) Template (Macro Enabled)",   text_value: "xltm")
  pg.properties.create(name: "Microsoft Office Excel (2007+) Template",                   text_value: "xltx")
end

print "Multimedia file type\n"
unless PropertyGroup.exists?(name: "Multimedia files")
  pg = PropertyGroup.create(name: "Multimedia files", description: "File extension of multimedia files", active: true, type:"text", property_group_id: file_extensions.id)
  pg.properties.create(name: "Advanced Audio Coding File",           text_value: "aac")
  pg.properties.create(name: "Dolby 5.1 Channel Sound Format",       text_value: "ac3")
  pg.properties.create(name: "Audio Interchange File",               text_value: "aif")
  pg.properties.create(name: "Audio Interchange File",               text_value: "aiff")
  pg.properties.create(name: "Monkeys Audio File",                   text_value: "ape")
  pg.properties.create(name: "Free Lossless Audio Codec File",       text_value: "flac")
  pg.properties.create(name: "Audio stream Raw GSM",                 text_value: "gsm")
  pg.properties.create(name: "Interchange File Format",              text_value: "iff")
  pg.properties.create(name: "MPEG-4 Audio Layer",                   text_value: "m4a")
  pg.properties.create(name: "MPEG-4 Audio Book File",               text_value: "m4b")
  pg.properties.create(name: "iTunes Audio Format",                  text_value: "m4p")
  pg.properties.create(name: "Apple iPhone Ringtone File",           text_value: "m4r")
  pg.properties.create(name: "Musical Instrument Digital Interface (MIDI) Sound File",  text_value: "mid")
  pg.properties.create(name: "Musical Instrument Digital Interface (MIDI) Sound File",  text_value: "midi")
  pg.properties.create(name: "MPEG Audio Stream",                    text_value: "mp2")
  pg.properties.create(name: "MP3 Audio File",                       text_value: "mp3")
  pg.properties.create(name: "MPEG Audio Stream",                    text_value: "mpa")
  pg.properties.create(name: "Musepack Audio File",                  text_value: "mpc")
  pg.properties.create(name: "Ogg Vorbis Audio",                     text_value: "oga")
  pg.properties.create(name: "Ogg Vorbis Codec Compressed WAV File", text_value: "ogg")
  pg.properties.create(name: "Waveform Audio",                       text_value: "wav")
  pg.properties.create(name: "Windows Media Audio File",             text_value: "wma")
  pg.properties.create(name: "Audio Video Interleave File",          text_value: "avi")
  pg.properties.create(name: "DivX Video File",                      text_value: "divx")
  pg.properties.create(name: "DivX Video File",                      text_value: "dvx")
  pg.properties.create(name: "Digital Video Recorder File",          text_value: "dvr")
  pg.properties.create(name: "Flash Video File",                     text_value: "flv")
  pg.properties.create(name: "Matroska Video Stream",                text_value: "mkv")
  pg.properties.create(name: "MJPEG Video File",                     text_value: "mjp")
  pg.properties.create(name: "QuickTime for Windows Movie",          text_value: "mov")
  pg.properties.create(name: "MPEG 4 Video File",                    text_value: "mp4")
  pg.properties.create(name: "MPEG Movie",                           text_value: "mpeg")
  pg.properties.create(name: "MPEG Video File",                      text_value: "mpg")
  pg.properties.create(name: "MPEG-2 Video",                         text_value: "mpg2")
  pg.properties.create(name: "Ogg Vorbis Video",                     text_value: "ogv")
  pg.properties.create(name: "OGG Vorbis Multiplexed Media File",    text_value: "ogx")
  pg.properties.create(name: "Shockwave Flash Object",               text_value: "swf")
  pg.properties.create(name: "DVD Video Object File",                text_value: "vob")
  pg.properties.create(name: "XVID Encoded Video File",              text_value: "xvid")
end


one_day = Property.joins(:property_group).where(property_groups: {code: "interval"}).where(properties: {code: "1_day"}).first
fourteen_days = Property.joins(:property_group).where(property_groups: {code: "interval"}).where(properties: {code: "14_days"}).first
starts_with = Property.joins(:property_group).where(property_groups: {code: "filter_type"}).where(properties: {code: "starts_with"}).first

print "creating domains ==============================================\n"
print "Trelleborg Sealing Solutions\n"
@domain = Domain.where(name: "Trelleborg Sealing Solutions").first_or_initialize
if @domain.new_record?
  @domain.account_id                = a.id
  @domain.name                      = "Trelleborg Sealing Solutions"
  @domain.domain                    = "www.tss.trelleborg.com"
  @domain.active                    = true
  @domain.check_content_for_changes = true
  @domain.check_publish_time        = true
  @domain.regx_publish_time         = "<!-- published (?<day>\d{2})\.(?<month>\d{2})\.(?<year>\d{4}) (?<hour>\d{2}):(?<min>\d{2}):(?<sec>\d{2}) -->"
  @domain.save

  print "areas\n"
  @domain.areas.create(name: "Global Site - News archive",       filter: "/global/en/news_1/newsarchive/", filter_type_property_id: starts_with.id, interval_property_id: fourteen_days.id)
  @domain.areas.create(name: "Global Site",                      filter: "/global/en", filter_type_property_id: starts_with.id, interval_property_id: one_day.id)
  @domain.areas.create(name: "German Site - News archive",       filter: "/de/de/news_1/newsarchive/", filter_type_property_id: starts_with.id, interval_property_id: fourteen_days.id)
  @domain.areas.create(name: "German Site",                      filter: "/de/de", filter_type_property_id: starts_with.id, interval_property_id: one_day.id)
  @domain.areas.create(name: "complete site",                    filter: "/", filter_type_property_id: starts_with.id, interval_property_id: one_day.id)

  print "containers\n"
  @domain.containers.create(name: "Main content", x_path:"//*[@id=\"content-home\"]\r\n//*[@id=\"content\"]")
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
  @domain.active                    = true
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
  @domain.domain                    = "www.orkotmarine.com"
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
  @domain.name                      = "Orkot Hydro Bearings"
  @domain.domain                    = "www.orkothydro.com"
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
  @domain.save

  print "containers\n"
  @domain.containers.create(name: "Main content", x_path: "//*[@id=\"main\"]")
  @domain.containers.create(name: "Top navigation", x_path: "//*[@id=\"navigation\"]",ignore:true)
end

print "Stihl\n"
@domain = Domain.where(name: "Stihl").first_or_initialize
if @domain.new_record?
  @domain.account_id                = a.id
  @domain.name                      = "Stihl"
  @domain.domain                    = "www.stihl.de"
  @domain.check_content_for_changes = true
  @domain.save

  print "containers\n"
  @domain.containers.create(name: "Main content", x_path: "//*[@id=\"main_content\"]/div[2]")
  @domain.containers.create(name: "Top navigation", x_path: "//*[@id=\"navigation\"]",ignore:true)
  @domain.containers.create(name: "Left navigation", x_path: "//*[@id=\"left_navigation\"]",ignore:true)
end

print "SFE\n"
@domain = Domain.where(name: "SFE").first_or_initialize
if @domain.new_record?
  @domain.account_id                = a.id
  @domain.name                      = "SFE"
  @domain.domain                    = "www.sfe.de"
  @domain.check_content_for_changes = true
  @domain.save

  print "containers\n"
  @domain.containers.create(name: "Main content", x_path: "//*[@id='ctl4']")
  @domain.containers.create(name: "Top navigation", x_path: "//*[@id='main-nav']",ignore:true)
  @domain.containers.create(name: "Left navigation", x_path: "//*[@id='ctl12']",ignore:true)
end

print "VHS Herrenberg\n"
@domain = Domain.where(name: "VHS Herrenberg").first_or_initialize
if @domain.new_record?
  @domain.account_id                = a.id
  @domain.name                      = "VHS Herrenberg"
  @domain.domain                    = "www.vhs.herrenberg.de"
  @domain.check_content_for_changes = true
  @domain.save

  print "containers\n"
  @domain.containers.create(name: "Main content", x_path: "//*[@id=\"main\"]")
  @domain.containers.create(name: "Top navigation", x_path: "//*[@id=\"primary\"]",ignore:true)
  @domain.containers.create(name: "Left navigation", x_path: "//*[@id=\"block-menu-menu-departments\"]",ignore:true)

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
#  @domain.main_container            = "//div[@class='meldung_wrapper']\r//*[@id='artikel_shortnews']\r//*[@id='bildergalerie']\r//*[@id='mitte_artikel']"
#  @domain.navigation_container      = "//*[@id='heisetopnavi_sub_container']"
#  @domain.subnavigation_container   = "//*[@id='mitte_rechts']"
  @domain.save
end
