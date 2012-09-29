require "open-uri"

class WebPageAnalyser

  def self.get_publish_date(url1, mask="<!-- published (.*?) -->")
    #data = open(url1)
    #r = Regexp.new("<!-- published (.*?) -->")
    #result = r.match(data)
    #return result ? result[1] : "not found"
    return url1
  end

end