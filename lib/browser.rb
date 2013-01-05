require "watir-webdriver"
require "oily_png"

class Browser
  ######################################################################################################################
  # start_browser
  ######################################################################################################################
  def self.start_browser()
    Rails.logger.debug("start_browser (g)")
    @browser_instance = Watir::Browser.new :chrome
  end

  ######################################################################################################################
  # stop_browser
  ######################################################################################################################
  def self.stop_browser()
    Rails.logger.debug("stop_browser (r)")
    @browser_instance.close
  end

  ######################################################################################################################
  # create_screen_shot
  ######################################################################################################################
  def self.create_screen_shot(page)
    #Script for fixing problems with not visible flash
    script = "var s = document.createElement('script');"\
            "s.src = 'http://www.schittenhelm.de/param_fix.js';"\
            "document.body.appendChild(s);"

    uri = WebPageAnalyser.get_uri(page)
    @browser_instance.goto uri
    @browser_instance.execute_script(script)
    sleep 3.5 # Waiting for flash to load
    Rails.logger.debug "create_screen_shot - making screenshot of #{uri}"
    picture = OilyPNG::Canvas.from_blob(@browser_instance.screenshot.png)
    directory = sprintf('%06d-%06d',page.domain.id,ScreenShot.count / 1000 + 1) # Create a directory for every 1000 pictures
    unless File.directory?(File.expand_path("public\\screenshots\\originals\\#{directory}"))
      Rails.logger.info "create_screen_shot - creating new directory for screenshots #{directory}"
      Dir.mkdir(File.expand_path("public\\screenshots\\originals\\#{directory}"),0700)
    end
    unless File.directory?(File.expand_path("public\\screenshots\\thumbs\\#{directory}"))
      Rails.logger.info "create_screen_shot - creating new directory for screenshot thumbs #{directory}"
      Dir.mkdir(File.expand_path("public\\screenshots\\thumbs\\#{directory}"),0700)
    end

    uuid = UUIDTools::UUID.random_create.to_s
    original_width = picture.width
    original_height = picture.height
    thumb_width = 200
    thumb_height = (original_height / (original_width.to_f / thumb_width.to_f)).to_i
    Rails.logger.debug "create_screen_shot - saving screenshot to public\\screenshots\\originals\\#{directory}\\#{uuid}.png"
    picture.save("public\\screenshots\\originals\\#{directory}\\#{uuid}.png", :best_compression)
    picture.resample_nearest_neighbor!(thumb_width,thumb_height)
    picture.save("public\\screenshots\\thumbs\\#{directory}\\#{uuid}.png", :best_compression)
    ScreenShot.create(uuid: uuid, domain_id: page.domain_id, page_id: page.id, directory: directory)
  end
end