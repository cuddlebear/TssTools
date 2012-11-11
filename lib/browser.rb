require "watir-webdriver"
require "oily_png"

class Browser
  def self.start_browser()
    @browser_instance = Watir::Browser.new :chrome
  end

  def self.stop_browser()
    @browser_instance.close
  end

  def self.create_screen_shot(page)

    script = "var s = document.createElement('script');"\
            "s.src = 'http://www.schittenhelm.de/param_fix.js';"\
            "document.body.appendChild(s);"

    url = WebPageAnalyser.get_uri_from_page(page)
    @browser_instance.goto url
    @browser_instance.execute_script(script)
    #@browser_instance.WebDriverWait 5
    sleep 3.5
    i = OilyPNG::Canvas.from_blob(@browser_instance.screenshot.png)
    directory = "000003"
    uuid = UUIDTools::UUID.random_create.to_s
    original_width = i.width
    original_height = i.height
    thumb_width = 200
    thumb_height = (original_height / (original_width.to_f / thumb_width.to_f)).to_i
    i.save("public\\screenshots\\originals\\#{directory}\\#{uuid}.png", :best_compression)
    i.resample_nearest_neighbor!(thumb_width,thumb_height)
    i.save("public\\screenshots\\thumbs\\#{directory}\\#{uuid}.png", :best_compression)
    ScreenShot.create(uuid: uuid, domain_id: page.domain_id, page_id: page.id, directory: directory)
  end
end