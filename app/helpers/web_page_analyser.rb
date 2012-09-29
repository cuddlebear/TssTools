
require 'nokogiri'
require 'open-uri'

class WebPageAnalyser
  unloadable

  def self.get_publish_date(url1, mask="<!-- published (.*?) -->")
    #data = open(url1)
    #r = Regexp.new("<!-- published (.*?) -->")
    #result = r.match(data)
    #return result ? result[1] : "not found"
    return url1
  end

  def self.initialize_page(page)
    doc = nil
    begin
      url = page.domain.scheme + "://" + page.domain.domain + (page.domain.port? ? ":" + page.domain.port : "") + page.path
      doc = Nokogiri::HTML(open(url))
    rescue => e
      page.title = "Error retrieving page"
      page.save
    end
    unless doc.nil?
      title =  doc.at_css("/html/head/title").text
      page.title = title
      page.save
    end

  end

end