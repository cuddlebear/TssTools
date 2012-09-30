
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

  def self.analyze_content(filter, dom, domain_id)
    content = ""
    if filter.nil? == false and filter

      filter.split(/\r\n/).each do |match|
        tmp = dom.at_css(match)
        unless tmp.nil?
          tmp.css('a[@href]').each do |link|
            if link['href'].start_with?("/") && link['href'].index("?") == nil
              unless Page.where(domain_id: domain_id, path: link['href']).exists?
                Page.create(domain_id: domain_id, path:link['href'])
                content += link['href'] +"<br />"
              end
            end

          end
          content += tmp.inner_html
        end
      end
    end
    return content
  end

end