require 'nokogiri'
require_relative 'request'

logger = Logger.new('system3.log')


TimeSq.new(1).init_folder


main = Nokogiri::HTML(File.read("main"))

catas = {}

main.xpath("//td[@class='catagories']").each do |c|
  catas[c.attr('id')] = c.to_html.match(/(?<=<bodytext>)(\w| |\/)+/)
end

catas.key.each do |ccc|
  TimeSq.new(1).download_cata(ccc)
end  

Timesq.new(1).download_images

catas_shop = {}

(catas.keys - ["all"]).each do |ca|
  catas_shop[ca] = Nokogiri::HTML(File.read("data/map/#{ca}")).xpath("//a").map{|s| s.attr('href').delete("shop_detail.php?shop=")}
end

f = File.open("data/catas", 'w')
  f.puts catas
  f.puts catas_shop

shop_ids = catas_shop.values.flatten.uniq

# shop_ids.each do |s|
#   TimeSq.new(s).download
# end  

threads = []


shop_ids.each_slice(40).map do |r|
  threads << Thread.new { r.each{|num| TimeSq.new(num).download unless File.exist?("data/detail/#{num}")} ;  logger.info "#{r} #{threads} end" }

  logger.info "#{r} #{threads}"
  # debugger
end


threads.each { |thread| thread.join }



1

