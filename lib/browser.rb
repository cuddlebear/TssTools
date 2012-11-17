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
    #Script for fixing problems with not visible flash
    script = "var s = document.createElement('script');"\
            "s.src = 'http://www.schittenhelm.de/param_fix.js';"\
            "document.body.appendChild(s);"

    url = WebPageAnalyser.get_uri(page)
    @browser_instance.goto url
    @browser_instance.execute_script(script)
    sleep 3.5 # Waiting for flash to load
    Rails.logger.debug "Making screenshot of #{url}"
    picture = OilyPNG::Canvas.from_blob(@browser_instance.screenshot.png)
    directory = '%06d' % (ScreenShot.count / 1000+1) # Create a directory for every 1000 pictures
    unless File.directory?(File.expand_path("public\\screenshots\\originals\\#{directory}"))
      Rails.logger.info "Creating new directory for screenshots #{directory}"
      Dir.mkdir(File.expand_path("public\\screenshots\\originals\\#{directory}"),0700)
      Dir.mkdir(File.expand_path("public\\screenshots\\thumbs\\#{directory}"),0700)
    end

    uuid = UUIDTools::UUID.random_create.to_s
    original_width = picture.width
    original_height = picture.height
    thumb_width = 200
    thumb_height = (original_height / (original_width.to_f / thumb_width.to_f)).to_i
    picture.save("public\\screenshots\\originals\\#{directory}\\#{uuid}.png", :best_compression)
    picture.resample_nearest_neighbor!(thumb_width,thumb_height)
    picture.save("public\\screenshots\\thumbs\\#{directory}\\#{uuid}.png", :best_compression)
    ScreenShot.create(uuid: uuid, domain_id: page.domain_id, page_id: page.id, directory: directory)
  end
end