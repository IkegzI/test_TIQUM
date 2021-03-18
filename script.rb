require 'open-uri'
require 'nokogiri'
# https://rb7.ru/afisha/movies
#

def clear
  if Gem.win_platform?
    system('cls')
  else
    system('clear')
  end
end

clear
html = open('https://rb7.ru/afisha/movies').read
doc = Nokogiri::HTML(html)
hash_cinema = {}
hash_session = {}
doc.xpath("//*[@class=\"movie\"]").each do |cinema|
  hash_cinema[cinema.css("h2").css("a").text] ||= 0
  cinema.css('.when').css('.show').each { |ch| hash_cinema[cinema.css("h2").css("a").text] += 1 }
  hash_session[hash_cinema[cinema.css("h2").css("a").text]] = cinema.css("h2").css("a").text
end

arr_session_sort_data = hash_cinema.values.sort

1.upto(3) do |i|
  puts "#{i}. #{hash_session[arr_session_sort_data[i * (-1)]]} (#{arr_session_sort_data[i * (-1)]} пок.)"
end

puts('Нажмите "Enter", чтобы выйти')
gets
clear