require_relative 'shop_parser'

Dir["data/p?/*"].each do |file|
  html = File.read(file)
  path = file[5..-1].gsub('/','_')
  # puts path
  ShopUrlParser.new(path, html).parse
end  