require_relative 'shop'

def inser_file(file)
  File.open(file) do |f|
    f.each_line do |line|
      Shop.insert_shop(line)
    end
  end
end

# ll = '60763^1006639^Chipotle Mexican Grill^304 W. 34th. Street, New York City, NY 10001 (Garment District)^<span rel="v:address"><span class="format_address"><span class="street-address" property="v:street-address">304 W. 34th. Street</span>, <span class="locality"><span property="v:locality">New York City</span>, <span property="v:region">NY</span> <span property="v:postal-code">10001</span></span> </span></span>(Garment District)^(212) 268-4197^40.753361,^4.0^309^31 元 - 62 元^ Mexican ^ Families with children, Dining on a budget ^ Breakfast/Brunch, Lunch, Dinner, Takeout, Delivery, Late Night ^ Garment District ^85^Excellent:130,Very good:135,Average:32,Poor:9,Terrible:3^Food:81,Service:72,Value:81,Atmosphere:63'
# inser_file("../TAPOI2/60763.info")

files = Dir["../TAPOI2/*.info"]

# files.each_slice(2).each do |fs|
#   threads = []
#   fs.each do |f|
#     threads << Thread.new { inser_file(f) }
#   end
#   threads.each { |thread| thread.join }
# end  

files.each do |f|
  inser_file(f)
end  