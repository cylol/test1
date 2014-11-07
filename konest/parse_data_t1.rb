require_relative 'shop_parser'

result = File.new('result.log', 'w')

Dir["data/food/*", "data/clinic/*", "data/shop/*", "data/spot/*"].each do |file|
  parser = ShopParser.new(file.split('/')[-1], File.read(file))
  parser.parse
  result.puts parser.shop.to_json
end  