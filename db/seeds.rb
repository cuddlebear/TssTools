# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


print "start =========================================================\n"
print "\n"
print "creating accounts =============================================\n"
print "Sabine\n"
a = Account.create(name: "Sabines first account", active: true)
a.users.create(user_name: "Sabine", email: "sabine.mustermann@evil.orgs", first_name: "Sabine", last_name:"Mustermann", active: true, account_admin: true, super_admin: false)
print "Max\n"
a = Account.create(name: "Maxs first account", active: true)
a.users.create(user_name: "Max", email: "max.mustermann@evil.orgs", first_name: "Max", last_name:"Mustermann", active: true, account_admin: true, super_admin: true)
print "\n"

print "creating property groups ======================================\n"
print "Global settings\n"
unless PropertyGroup.exists?(name: "Global settinges")
  global_settings = PropertyGroup.create(name: "Global settings", description: "Global settings of application.", active: true, type:"int")

  print "Global settings numeric\n"
  unless PropertyGroup.exists?(name: "Global settings numeric")
    pg = PropertyGroup.create(name: "Global settings numeric", description: "Global numeric settings", active: true, type:"int", property_group_id: global_settings.id)
    pg.properties.create(name: "Page Size",     int_value: 25)
  end

  print "Global settings text\n"
  unless PropertyGroup.exists?(name: "Global settings text")
    pg = PropertyGroup.create(name: "Global settings text", description: "Global text settings", active: true, type:"string", property_group_id: global_settings.id)
    pg.properties.create(name: "Application name",            text_value: "TSS Tools")
    pg.properties.create(name: "detectlanguage.com API key",  text_value: "54773be03dacdff3fa3cf3f19a839423")
  end
end

print "Stati\n"
unless PropertyGroup.exists?(name: "Status")
  pg = PropertyGroup.create(name: "Status", description: "Describes the status of a domain or page.", active: true, type:"int")
  pg.properties.create(name: "New",           int_value: 0)
  pg.properties.create(name: "Unknown",       int_value: 1)
  pg.properties.create(name: "Maintenance",   int_value: 2)
  pg.properties.create(name: "Warning",       int_value: 3)
  pg.properties.create(name: "Critical",      int_value: 4)
  pg.properties.create(name: "OK",            int_value: 5)
end

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
# for later use in this script
one_day = Property.joins(:property_group).where(property_groups: {code: "interval"}).where(properties: {code: "1_day"}).first
fourteen_days = Property.joins(:property_group).where(property_groups: {code: "interval"}).where(properties: {code: "14_days"}).first

print "Filter types\n"
unless PropertyGroup.exists?(name: "Filter type")
  pg = PropertyGroup.create(name: "Filter type", description: "Type of filter to match area with url", active: true, type:"int")
  pg.properties.create(name: "Starts with",         int_value: 0)
  pg.properties.create(name: "Contains",            int_value: 1)
  pg.properties.create(name: "Regular expression",  int_value: 2)
end
# for later use in this script
starts_with = Property.joins(:property_group).where(property_groups: {code: "filter_type"}).where(properties: {code: "starts_with"}).first
contains = Property.joins(:property_group).where(property_groups: {code: "filter_type"}).where(properties: {code: "contains"}).first

print "Statistic type\n"
unless PropertyGroup.exists?(name: "Statistic type")
  pg = PropertyGroup.create(name: "Statistic type", description: "Period of time the statistic was made for ", active: true, type:"int")
  pg.properties.create(name: "Daily",               int_value: 0)
  pg.properties.create(name: "Weekly",              int_value: 1)
  pg.properties.create(name: "Monthly",             int_value: 2)
  pg.properties.create(name: "Yearly",              int_value: 3)
end

print "Statistic scope\n"
unless PropertyGroup.exists?(name: "Statistic scope")
  pg = PropertyGroup.create(name: "Statistic scope", description: "Range of pages, areas the statistic was made for ", active: true, type:"int")
  pg.properties.create(name: "Page",                int_value: 0)
  pg.properties.create(name: "Path",                int_value: 1)
  pg.properties.create(name: "Area",                int_value: 2)
  pg.properties.create(name: "Domain",              int_value: 3)
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

# for later use in this script
main_content = Property.joins(:property_group).where(property_groups: {code: "content_type"}).where(properties: {code: "main_content"}).first
navigation = Property.joins(:property_group).where(property_groups: {code: "content_type"}).where(properties: {code: "navigation"}).first
subnavigation = Property.joins(:property_group).where(property_groups: {code: "content_type"}).where(properties: {code: "subnavigation"}).first

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
  pg.properties.create(name: "Check page head only",  int_value: 101)
  pg.properties.create(name: "Check page exists",     int_value: 102)
  pg.properties.create(name: "Check content changes", int_value: 103)
  pg.properties.create(name: "Check publish time",    int_value: 104)
  pg.properties.create(name: "Make screen shot",      int_value: 105)
end

print "Languages\n"
unless PropertyGroup.exists?(name: "Language Code")
  pg = PropertyGroup.create(name: "Language Code", description: "Languages", active: true, type:"text")

  pg.properties.create(name: "unknown",          text_value: "xxx")
  pg.properties.create(name: "AFRIKAANS",        text_value: "af")
  pg.properties.create(name: "ARABIC",           text_value: "ar")
  pg.properties.create(name: "BELARUSIAN",       text_value: "be")
  pg.properties.create(name: "BULGARIAN",        text_value: "bg")
  pg.properties.create(name: "CATALAN",          text_value: "ca")
  pg.properties.create(name: "CHEROKEE",         text_value: "chr")
  pg.properties.create(name: "CZECH",            text_value: "cs")
  pg.properties.create(name: "WELSH",            text_value: "cy")
  pg.properties.create(name: "DANISH",           text_value: "da")
  pg.properties.create(name: "GERMAN",           text_value: "de")
  pg.properties.create(name: "DHIVEHI",          text_value: "dv")
  pg.properties.create(name: "GREEK",            text_value: "el")
  pg.properties.create(name: "ENGLISH",          text_value: "en")
  pg.properties.create(name: "SPANISH",          text_value: "es")
  pg.properties.create(name: "ESTONIAN",         text_value: "et")
  pg.properties.create(name: "PERSIAN",          text_value: "fa")
  pg.properties.create(name: "FINNISH",          text_value: "fi")
  pg.properties.create(name: "TAGALOG",          text_value: "fil")
  pg.properties.create(name: "FRENCH",           text_value: "fr")
  pg.properties.create(name: "IRISH",            text_value: "ga")
  pg.properties.create(name: "GUJARATI",         text_value: "gu")
  pg.properties.create(name: "HEBREW",           text_value: "he")
  pg.properties.create(name: "HINDI",            text_value: "hi")
  pg.properties.create(name: "CROATIAN",         text_value: "hr")
  pg.properties.create(name: "HUNGARIAN",        text_value: "hu")
  pg.properties.create(name: "ARMENIAN",         text_value: "hy")
  pg.properties.create(name: "ICELANDIC",        text_value: "is")
  pg.properties.create(name: "ITALIAN",          text_value: "it")
  pg.properties.create(name: "INUKTITUT",        text_value: "iu")
  pg.properties.create(name: "JAPANESE",         text_value: "ja")
  pg.properties.create(name: "GEORGIAN",         text_value: "ka")
  pg.properties.create(name: "KHMER",            text_value: "km")
  pg.properties.create(name: "KANNADA",          text_value: "kn")
  pg.properties.create(name: "KOREAN",           text_value: "ko")
  pg.properties.create(name: "LAOTHIAN",         text_value: "lo")
  pg.properties.create(name: "LITHUANIAN",       text_value: "lt")
  pg.properties.create(name: "LATVIAN",          text_value: "lv")
  pg.properties.create(name: "MACEDONIAN",       text_value: "mk")
  pg.properties.create(name: "MALAYALAM",        text_value: "ml")
  pg.properties.create(name: "MALAY",            text_value: "ms")
  pg.properties.create(name: "NORWEGIAN",        text_value: "nb")
  pg.properties.create(name: "DUTCH",            text_value: "nl")
  pg.properties.create(name: "ORIYA",            text_value: "or")
  pg.properties.create(name: "PUNJABI",          text_value: "pa")
  pg.properties.create(name: "POLISH",           text_value: "pl")
  pg.properties.create(name: "PORTUGUESE",       text_value: "pt")
  pg.properties.create(name: "ROMANIAN",         text_value: "ro")
  pg.properties.create(name: "RUSSIAN",          text_value: "ru")
  pg.properties.create(name: "SINHALESE",        text_value: "si")
  pg.properties.create(name: "SLOVAK",           text_value: "sk")
  pg.properties.create(name: "SLOVENIAN",        text_value: "sl")
  pg.properties.create(name: "SERBIAN",          text_value: "sr")
  pg.properties.create(name: "SWEDISH",          text_value: "sv")
  pg.properties.create(name: "SWAHILI",          text_value: "sw")
  pg.properties.create(name: "SYRIAC",           text_value: "syr")
  pg.properties.create(name: "TAMIL",            text_value: "ta")
  pg.properties.create(name: "TELUGU",           text_value: "te")
  pg.properties.create(name: "THAI",             text_value: "th")
  pg.properties.create(name: "TURKISH",          text_value: "tr")
  pg.properties.create(name: "UKRAINIAN",        text_value: "uk")
  pg.properties.create(name: "VIETNAMESE",       text_value: "vi")
  pg.properties.create(name: "YIDDISH",          text_value: "yi")
  pg.properties.create(name: "CHINESE",          text_value: "zh")
  pg.properties.create(name: "CHINESET",         text_value: "zh-TW")
end
# for later use in this script
language_en = Property.joins(:property_group).where(property_groups: {code: "language_code"}).where(properties: {code: "english"}).first
language_de = Property.joins(:property_group).where(property_groups: {code: "language_code"}).where(properties: {code: "german"}).first
language_fr = Property.joins(:property_group).where(property_groups: {code: "language_code"}).where(properties: {code: "french"}).first
language_it = Property.joins(:property_group).where(property_groups: {code: "language_code"}).where(properties: {code: "italian"}).first

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

print "\n"
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
  @domain.areas.last.destroy
  @domain.areas.create(name: "News archives",            filter: "/newsarchive/",                         filter_type_property_id: contains.id,    interval_property_id: fourteen_days.id)
  @domain.areas.create(name: "Austrian site",            filter: "/at/de/",                               filter_type_property_id: starts_with.id, interval_property_id: one_day.id, language_code_property_id: language_de.id)
  @domain.areas.create(name: "Belguim site",             filter: "/be/en/",                               filter_type_property_id: starts_with.id, interval_property_id: one_day.id, language_code_property_id: language_en.id)
  @domain.areas.create(name: "Brasilian site",           filter: "/br/pt/",                               filter_type_property_id: starts_with.id, interval_property_id: one_day.id)
  @domain.areas.create(name: "Bulgarian site",           filter: "/bg/bg/",                               filter_type_property_id: starts_with.id, interval_property_id: one_day.id)
  @domain.areas.create(name: "Global site",              filter: "/global/en/",                           filter_type_property_id: starts_with.id, interval_property_id: one_day.id, language_code_property_id: language_en.id)
  @domain.areas.create(name: "German site",              filter: "/de/de/",                               filter_type_property_id: starts_with.id, interval_property_id: one_day.id, language_code_property_id: language_de.id)
  @domain.areas.create(name: "Swiss site",               filter: "/ch/de/",                               filter_type_property_id: starts_with.id, interval_property_id: one_day.id, language_code_property_id: language_de.id)
  @domain.areas.create(name: "USA site",                 filter: "/us/en/",                               filter_type_property_id: starts_with.id, interval_property_id: one_day.id, language_code_property_id: language_en.id)
  @domain.areas.create(name: "all other parts",          filter: "/",                                     filter_type_property_id: starts_with.id, interval_property_id: one_day.id)

  print "containers\n"
  @domain.containers.create(name: "Main content",        content_type_property_id: main_content.id,       x_path:"//*[@id=\"content-home\"]\r\n//*[@id=\"content\"]")
  @domain.containers.create(name: "Top navigation",      content_type_property_id: navigation.id,         x_path:"//*[@id=\"navigation-area\"]")
  @domain.containers.create(name: "Left navigation",     content_type_property_id: subnavigation.id,      x_path:"//*[@id=\"leftnavi\"]")

  print "pages\n"
  #@domain.pages.create(path: "/global/en/homepage/homepage.html", title: "Hydraulic Seals, Rotary Shaft Seals, O-Rings by Trelleborg", active: true)
  #@domain.pages.create(path: "/global/en/industries/industries.html", title: "Industry Specific Solutions: Aerospace, Automotive, Marine, Food", active: true)
  #@domain.pages.create(path: "/global/en/industries/automotive/automotive.html", title: "Automotive Sealing Products, Seals & Gaskets: Automotive Industry", active: true)
  #@domain.pages.create(path: "/global/en/company/facts_1/tss-facts.html", title: "TSS Company Facts Company Profile  - Trelleborg", active: true)
  #@domain.pages.create(path: "/global/en/products_2/productrange.html", title: "", active: true)
  #@domain.pages.create(path: "/global/en/industries/industries.html", title: "", active: true)
  #@domain.pages.create(path: "/global/en/news_1/newsoverview/newsoverview.html", title: "", active: true)
  #@domain.pages.create(path: "/global/en/service/service.html", title: "", active: true)
  #@domain.pages.create(path: "/global/en/contact_1/contactform/contact-form.html", title: "", active: true)
  #@domain.pages.create(path: "/global/en/company/manufacturingcapabilities/index.html", title: "", active: true)
  #@domain.pages.create(path: "/global/en/news_1/newsarchive/archive2010/archiveoverview-2010.html", title: "", active: true)
  #@domain.pages.create(path: "/global/en/products_2/orings_2/o-ring.html", title: "", active: true)
  #@domain.pages.create(path: "/global/en/products_2/siliconetubingandhose/silicone-tubing-and-hose.html", title: "", active: true)
end
print "\n"
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
  @domain.containers.create(name: "Main content",    content_type_property_id: main_content.id,  x_path:"//*[@id=\"subpage\"]")
  @domain.containers.create(name: "Top navigation",  content_type_property_id: navigation.id,    x_path:"//*[@id=\"topmenu\"]")
  @domain.containers.create(name: "Left navigation", content_type_property_id: subnavigation.id, x_path:"//*[@id=\"leftmenu\"]")
end

print "\n"
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
  @domain.containers.create(name: "Main content",    content_type_property_id: main_content.id, x_path:'/html/body/table')
  @domain.containers.create(name: "Top navigation",  content_type_property_id: navigation.id,   x_path:'//*[@id="menu0"]')
end

print "\n"
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
  @domain.containers.create(name: "Main content",    content_type_property_id: main_content.id, x_path:'/html/body/table')
  @domain.containers.create(name: "Top navigation",  content_type_property_id: navigation.id,   x_path:'//*[@id="menu0"]')
end

print "\n"
print "Schittenhelm\n"
@domain = Domain.where(name: "Schittenhelm private homepage").first_or_initialize
if @domain.new_record?
  @domain.account_id                = a.id
  @domain.name                      = "Schittenhelm private homepage"
  @domain.domain                    = "www.schittenhelm.de"
  @domain.check_content_for_changes = true
  @domain.save

  print "containers\n"
  @domain.containers.create(name: "Main content",    content_type_property_id: main_content.id, x_path: "//*[@id=\"main\"]")
  @domain.containers.create(name: "Top navigation",  content_type_property_id: navigation.id,   x_path: "//*[@id=\"navigation\"]")
end

print "\n"
print "Stihl\n"
@domain = Domain.where(name: "Stihl").first_or_initialize
if @domain.new_record?
  @domain.account_id                = a.id
  @domain.name                      = "Stihl"
  @domain.domain                    = "www.stihl.de"
  @domain.check_content_for_changes = true
  @domain.save

  print "containers\n"
  @domain.containers.create(name: "Main content",    content_type_property_id: main_content.id,  x_path: "//*[@id=\"main_content\"]/div[2]")
  @domain.containers.create(name: "Top navigation",  content_type_property_id: navigation.id,    x_path: "//*[@id=\"navigation\"]")
  @domain.containers.create(name: "Left navigation", content_type_property_id: subnavigation.id, x_path: "//*[@id=\"left_navigation\"]")
end

print "\n"
print "SFE\n"
@domain = Domain.where(name: "SFE").first_or_initialize
if @domain.new_record?
  @domain.account_id                = a.id
  @domain.name                      = "SFE"
  @domain.domain                    = "www.sfe.de"
  @domain.check_content_for_changes = true
  @domain.save

  print "containers\n"
  @domain.containers.create(name: "Main content",    content_type_property_id: main_content.id,  x_path: "//*[@id='ctl4']")
  @domain.containers.create(name: "Top navigation",  content_type_property_id: navigation.id,    x_path: "//*[@id='main-nav']")
  @domain.containers.create(name: "Left navigation", content_type_property_id: subnavigation.id, x_path: "//*[@id='ctl12']")
end

print "\n"
print "VHS Herrenberg\n"
@domain = Domain.where(name: "VHS Herrenberg").first_or_initialize
if @domain.new_record?
  @domain.account_id                = a.id
  @domain.name                      = "VHS Herrenberg"
  @domain.domain                    = "www.vhs.herrenberg.de"
  @domain.check_content_for_changes = true
  @domain.save

  print "containers\n"
  @domain.containers.create(name: "Main content",    content_type_property_id: main_content.id,  x_path: "//*[@id=\"main\"]")
  @domain.containers.create(name: "Top navigation",  content_type_property_id: navigation.id,    x_path: "//*[@id=\"primary\"]")
  @domain.containers.create(name: "Left navigation", content_type_property_id: subnavigation.id, x_path: "//*[@id=\"block-menu-menu-departments\"]")

  #@domain.pages.create(path: "/kursliste/147", title: "", active: true)
  #@domain.pages.create(path: "/kursliste/143", title: "", active: true)
  #@domain.pages.create(path: "/kultur-kunst-gestalten-musik/informationen", title: "", active: true)
end

print "Simrit\n"
@domain = Domain.where(name: "Simrit").first_or_initialize
if @domain.new_record?
  @domain.account_id                = a.id
  @domain.name                      = "Simrit"
  @domain.domain                    = "www.simrit.de"
  @domain.check_content_for_changes = true
  @domain.save

  print "containers\n"
  @domain.containers.create(name: "Main content",    content_type_property_id: main_content.id,  x_path: "//*[@id=\"layout-middle-container\"]/div/div[3]")
  @domain.containers.create(name: "Top navigation",  content_type_property_id: navigation.id,    x_path: "//*[@id=\"navbar\"]")
  @domain.containers.create(name: "Left navigation", content_type_property_id: subnavigation.id, x_path: "//*[@id=\"layout-middle-container\"]/div/div[1]/div[1]")
end

print "AHP seals\n"
@domain = Domain.where(name: "AHP seals").first_or_initialize
if @domain.new_record?
  @domain.account_id                = a.id
  @domain.name                      = "AHP seals"
  @domain.domain                    = "www.ahpseals.com"
  @domain.check_content_for_changes = true
  @domain.save

  print "containers\n"
  @domain.containers.create(name: "Main content",    content_type_property_id: main_content.id,  x_path: "//*[@id=\"l-col-home\"]  //*[@id=\"l-col\"]")
  @domain.containers.create(name: "Top navigation",  content_type_property_id: navigation.id,    x_path: "//*[@id=\"menu\"]")
  @domain.containers.create(name: "Left navigation", content_type_property_id: subnavigation.id, x_path: "//*[@id=\"r-col\"]")
end

print "Eriks\n"
@domain = Domain.where(name: "Eriks").first_or_initialize
if @domain.new_record?
  @domain.account_id                = a.id
  @domain.name                      = "Eriks"
  @domain.domain                    = "eriks.com"
  @domain.check_content_for_changes = true
  @domain.save

  print "containers\n"
  @domain.containers.create(name: "Main content",    content_type_property_id: main_content.id,  x_path: "//*[@id=\"content\"]")
  @domain.containers.create(name: "Top navigation",  content_type_property_id: navigation.id,    x_path: "//*[@id=\"main-nav\"]")
  @domain.containers.create(name: "Left navigation", content_type_property_id: subnavigation.id, x_path: "//*[@id=\"sidenav\"]")
  @domain.containers.create(name: "Site links",      content_type_property_id: subnavigation.id, x_path: "//*[@id=\"siteLinks\"]")
end
