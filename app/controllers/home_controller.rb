class HomeController < ApplicationController
  def index
    require 'rubygems'
    require 'nokogiri'
    require 'open-uri'

    url = "http://www.tss.trelleborg.com/global/en/industries/industries.html"
    doc = Nokogiri::HTML(open(url))
    @erg =  doc.at_css("/html/head/title").text
  end
end

