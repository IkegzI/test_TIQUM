require 'open-uri'
require 'nokogiri'
require 'pry'
# https://rb7.ru/afisha/movies
#

def clear
  if Gem.win_platform?
    system('cls')
  else
    system('clear')
  end
end

#Этот код необходим только при использовании русских букв на Windows
if (Gem.win_platform?)
  Encoding.default_external = Encoding.find(Encoding.locale_charmap)
  Encoding.default_internal = __ENCODING__

  [STDIN, STDOUT].each do |io|
    io.set_encoding(Encoding.default_external, Encoding.default_internal)
  end
end

clear
#формируем документ для парсинга
html = open('https://rb7.ru/afisha/movies').read
doc = Nokogiri::HTML(html)
hash_cinema = {}
hash_session = {}

date = Date.parse(doc.xpath("//*[@class=\"overscroll\"]").css('.active').css('.date').text)
amount = 0
# находим сумму показов в каждом кинотаеатре
doc.xpath("//*[@class=\"movie\"]").each do |cinema|
  hash_cinema[cinema.css("h2").css("a").text] ||= 0
  cinema.css('.when').css('.show').each { |ch| hash_cinema[cinema.css("h2").css("a").text] += 1 }
  amount += hash_cinema[cinema.css("h2").css("a").text]
end

print "С #{date} по #{date + 6} всего показов кинолент - #{amount}"
puts
puts
arr_session_sort_data = Hash[hash_cinema.sort_by{|_, value| value}] #СОРТИРОВКА ПО ЗНАЧЕНИЮ

1.upto(3) do |i|
  puts "#{i}. #{arr_session_sort_data.keys[i * (-1)]} (#{arr_session_sort_data[arr_session_sort_data.keys[i * (-1)]]} пок.)"
end
#
puts
puts('Нажмите "Enter", чтобы выйти...')
gets
clear