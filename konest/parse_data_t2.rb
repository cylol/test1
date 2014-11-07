require_relative 'shop_parser'

result = File.new('result2.log', 'w')

Dir["data/t2/*"].each do |file|
  parser = ShopParserT2.new(file.split('/')[-1], File.read(file))
  parser.parse
  result.puts parser.shop.to_json
end  