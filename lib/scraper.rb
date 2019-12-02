require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = Nokogiri::HTML(open(index_url))
    student_info = html.css(".student-card")
    students = []
    student_info.each do |student|
      student_hash = {}
      student_hash[:name] = student.css("h4").text
      student_hash[:location] = student.css("p").text
      student_hash[:profile_url] = student.css("a")[0]["href"]
      students << student_hash
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    html = Nokogiri::HTML(open(profile_url))
    student_hash = {}
    student_hash[:bio] = html.css(".bio-content p").text
    student_hash[:profile_quote] = html.css(".profile-quote").text
    social_media_array = html.css(".social-icon-container")
    social_media_array.css("a").length.times do |i|
      link = social_media_array.css("a")[i]["href"]
      if link.match(/linkedin/)
        student_hash[:linkedin] = link 
      elsif link.match(/twitter/)
        student_hash[:twitter] = link 
      elsif link.match(/github/)
        student_hash[:github] = link
      else 
        student_hash[:blog] = link
      end
    end
    student_hash
  end

end

Scraper.scrape_profile_page("https://learn-co-curriculum.github.io/student-scraper-test-page/students/eric-chu.html")