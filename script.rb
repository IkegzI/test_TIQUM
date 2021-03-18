require 'open-uri'
require 'nokogiri'
# https://rb7.ru/afisha/movies
#
html = open('https://rb7.ru/afisha/movies').read
doc = Nokogiri::HTML(html)
hash = {}
doc.xpath("//*[@class=\"movie\"]").each do |cinema|
  hash[cinema.css("h2").css("a").text] ||= 0
  cinema.css('.when').css('.show').each{|ch| hash[cinema.css("h2").css("a").text] += 1}
end

