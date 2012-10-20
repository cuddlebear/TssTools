
require 'nokogiri'
require 'open-uri'
require 'digest/md5'

class WebPageAnalyser
  unloadable

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
        match = match.strip
        tmp = dom.at_css(match)
      end
    end
    return content
  end

  def self.analyze_links(tmp)
    unless tmp.nil?
      tmp.css('a[@href]').each do |link|
        if link['href'].start_with?("/") && link['href'].index("?") == nil
          unless link['href'].index(/\.(jpg|jpeg|gif|png|ico|xls|xlsx|doc|docx|ppt|pptx|pdf|img|zip|rar|tar|gz|flv|mp3|ogg|mkv|mp4|avi|wav|ape|aac|ac3|mpg|mpeg|eps)/)
            unless Page.where(domain_id: domain_id, path: link['href']).exists?
              area_id = nil
              Area.where(:domain_id => domain_id).rank(:row_order).all do |area|
                regx = area.filter
                if area.filter_type_property.code == "starts_with"
                  regx = "^" + regx
                end
                if link['href'].rindex(Regexp.new(regx)) > 0
                  area_id = area.id
                  break
                end
              end
              Page.create(domain_id: domain_id, path: link['href'], area_id: area_id)
              #content += link['href'] +"<br />"
            end
          end
        end
      end
      content += tmp.inner_html
    end

  end

  def self.get_publish_time(filter, dom)
    x = dom.to_html
    r = Regexp.new(filter,"i").match(dom.to_html)
    unless r == nil
      publish_date = DateTime.new(r[:year],r[:month],r[:day],r[:hour],r[:min],r[:sec])
    else
      publish_date = nil
    end
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
    to_check = Check.includes(:page).includes(:page => :domain).find(id)
    if to_check.page.domain.active                      # Only check on active domains
      doc = nil
      # Retrieving the page
      begin                                             # don't check pictures, docs...
        unless to_check.page.path.index(/\.(jpg|jpeg|gif|png|ico|xls|xlsx|doc|docx|ppt|pptx|pdf|img|zip|rar|tar|gz|flv|mp3|ogg|mkv|mp4|avi|wav|ape|aac|ac3|mpg|mpeg|eps)/)
          url = to_check.page.domain.scheme + "://" + to_check.page.domain.domain + (to_check.page.domain.port? ? ":" + to_check.page.domain.port : "") +to_check.page.path
          doc = Nokogiri::HTML(open(url))               # retrieve url
        end
      rescue => e
        to_check.page.title = "Error retrieving page"
        to_check.page.status = 1
      end
      # Analysing the result
      unless doc.nil?
        # Getting the title
        if doc.at_css("/html/head/title")
          to_check.page.title =  doc.at_css("/html/head/title").text
        else
          to_check.page.title =  "no title tag"
        end
        if to_check.page.domain.check_publish_time?
          to_check.page.last_publish = get_publish_time(to_check.page.domain.regx_publish_time,doc)
        end
        to_check.page.status = 5
        # Analysing the content for changes
        if to_check.page.domain.check_content_for_changes
          @containers = Container.where(domain_id: to_check.page.domain_id)
          @containers.each do |container|

            container_content = ""
            container.x_path.split(/\r\n/).each do |match|
              match = match.strip
              tmp = doc.at_css(match)
              unless tmp.nil?
                container_content = tmp.inner_html
              end
            end
            container_content = WebPageAnalyser.normalize_html(container_content)
            md5_hash = Digest::MD5.hexdigest(container_content)
            content = Content.where(md5_hash: md5_hash ).first_or_initialize
            if content.new_record?
              # fill the new content
              content.container_id   = container.id
              content.md5_hash       = md5_hash
              content.text           = container_content
              content.links_internal = 0
              content.links_external = 0
              content.links_file     = 0
              content.headlines      = container_content.scan(/(<h[1-7].*?>.*?<\/h[1-7]>)/m).size
              content.words          = container_content.gsub(/<[^<]*?>/m," ").gsub(/(\s)\s+/,"\\1").scan(/(\S+)/mi).size

              # Analyse the links in the content
              dom = Nokogiri::HTML::DocumentFragment.parse(container_content)
              dom.css('a[@href]').each do |link|
                if link['href'].start_with?("/") && link['href'].index("?") == nil
                  unless link['href'].index(/\.(jpg|jpeg|gif|png|ico|xls|xlsx|doc|docx|ppt|pptx|pdf|img|zip|rar|tar|gz|flv|mp3|ogg|mkv|mp4|avi|wav|ape|aac|ac3|mpg|mpeg|eps)/)
                    content.links_internal += 1
                    unless Page.where(domain_id: to_check.page.domain_id, path: link['href']).exists?
                      area_id = nil
                      Area.where(:domain_id => to_check.page.domain_id).rank(:row_order).all do |area|
                        regx = area.filter
                        if area.filter_type_property.code == "starts_with"
                          regx = "^" + regx
                        end
                        if link['href'].rindex(Regexp.new(regx)) > 0
                          area_id = area.id
                          break
                        end
                      end
                      Page.create(domain_id: to_check.page.domain_id, path: link['href'], area_id: area_id)
                    end
                  else
                    content.links_file += 1
                  end
                else
                  content.links_external += 1
                end
              end
              content.save
            end

            page_content = to_check.page.page_contents.where(content_id: content.id).first_or_initialize
            if page_content.new_record?
              page_content.content_id = content.id
              page_content.from = DateTime.now
            end
            page_content.until = DateTime.now
            page_content.save
          end
        end
      end
      to_check.page.save
      to_check.page.last_check= DateTime.now
      to_check.result_code= 0
      to_check.save
    end
  end

end