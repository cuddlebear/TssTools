
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
          break
        end
      end
    end
    return content
  end

  def self.normalize_html(html)
    html = html.gsub(/\t/,"").gsub(/\r/,"").gsub(/  +/," ").gsub(/^ +/,"").
        gsub(/<script.*?<\/script>/m,"").
        gsub(/<iframe.*?<\/iframe>/m,"[iframe]").
        gsub(/<!--.*?-->/m,"").
        gsub(/<(\/|)(div|p|ol|ul|li|dt|dd|noscript|html|head|body|table|thead|tbody|tr|section|article|aside|header|footer|nav|details).*?>/m,"\n").
        gsub(/ (class|name|value|style|id|width|height|target|alt|rel|title|onload|onclick|onfocus|onmouseover|onblur|onmouseout)="[^"]*?"/m,"").
        gsub(/<(\/|)(strong|span|b|i|u|em|time|progress|label)>/m,"").
        gsub(/<(td|th)(.*?)>\n/m,"<\\1\\2>").
        gsub(/<\/(td|th)>\n/m,"</\\1>").
        gsub(/<(\/|)(br|br \/|td|th).*?>/m," ").
        gsub(/(\s)\s+/,"\\1").gsub(/^\s/,"").gsub(/>\s+?</,"><").
        gsub(/\n\n+/,"\n").
        gsub(/([^\n])<(img)(.*?)>/m,"\\1\n<\\2\\3>").gsub(/([^\n])<(img)(.*?)>/m,"\\1\n<\\2\\3>").
        gsub(/<(img)(.*?)>([^\n])/m,"<\\1\\2>\n\\3").gsub(/<(img)(.*?)>([^\n])/m,"<\\1\\2>\n\\3").
        gsub(/<(img) (.*?)(src=".*?")(.*?)>/m,"<\\1 \\3>").
        gsub(/<(h1|h2|h3|h4|h5|h6|h7)(.*?)>([\n])/m,"<\\1\\2>").
        gsub(/<\/(h1|h2|h3|h4|h5|h6|h7)>([^\n])/m,"</\\1>\n\\2").
        gsub(/\n<\/(h1|h2|h3|h4|h5|h6|h7)(.*?)>/m,"</\\1\\2>").
        gsub(/\s+\n/,"\n").gsub(/\n\n+/,"\n").gsub(/> +</m,"><").
        gsub(/>\n(<img.*?>)\n</m,">\\1<")
  end

  def self.beautify_html(html)
    result = ""
    html = html.gsub(/<img.*?>/m," [image] ").gsub(/(<a.*?<\/a>)/m," \\1 ")
    html.each_line {|l|
      l = l.strip
      if l.start_with?('<') == false && l.end_with?('>') == false
        result += "<p>"
      else
#        result += "#"
      end
      result += l
      if l.start_with?("<") == false && l.end_with?(">") == false
        result += "</p>"
      else
        result += " "
      end
    }
    return result
  end

  def self.check_page(id)
    check = Check.find(id)
    doc = nil
    begin
      url = check.page.domain.scheme + "://" + check.page.domain.domain + (check.page.domain.port? ? ":" + check.page.domain.port : "") +check.page.path
      doc = Nokogiri::HTML(open(url))
    rescue => e
      check.page.title = "Error retrieving page"
      check.page.status = 1
    end
    unless doc.nil?
      if doc.at_css("/html/head/title")
        check.page.title =  doc.at_css("/html/head/title").text
      else
        check.page.title =  "no title tag"
      end
      check.page.status = 5
      #main_content = WebPageAnalyser.analyze_content(check.page.domain.main_container,doc, check.page.domain_id)
      #navigation_content  = WebPageAnalyser.analyze_content(check.page.domain.navigation_container,doc, check.page.domain_id)
      #subnavigation_content  = WebPageAnalyser.analyze_content(check.page.domain.subnavigation_container,doc, check.page.domain_id)
    end
    check.page.save
    check.result_code= 0
    check.save
  end

end