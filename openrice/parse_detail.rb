require_relative 'shop_parser'

result = File.new('result.log', 'w')

Dir["data/map/*"].each do |f|
  id = f.split('/')[-1]
  p = ShopParser.new(id, File.read("data/detail/#{id}"), File.read(f))
  p.parse
  result.puts p.shop.to_json
end  
