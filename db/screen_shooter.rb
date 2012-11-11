require "yaml"
require "watir-webdriver"
require "../db/schema"

class ScreenShooter
  ActiveRecord::Base.establish_connection(YAML.load_file("../config/database.yml"))
  # To change this template use File | Settings | File Templates.
  User.create(name: "test1")
end