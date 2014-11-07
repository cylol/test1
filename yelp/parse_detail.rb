require_relative 'shop_parser'

result = File.new('resultyelp.log', 'w')

Dir["data/detaili/*"].each do |file|
  # begin
  parser = ShopParser.new(file.split('/')[-1], File.read(file))
  parser.parse

  result.puts parser.shop.to_json
  # rescue
  #   debugger
  # end
  # 1  
end  