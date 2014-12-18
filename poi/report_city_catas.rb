require_relative 'shop'

city_ids = Shop.select(:city_id).uniq.map{|s| s.city_id }

city_map = {2332 => '美国其他',343 => '外国其他'}

city_ids.each do |city_id|
  # city_shop_ids =  Shop.where(city_id: city_id).pluck(:shop_id)
  puts '-----------------------------------------'
  puts "city_id: #{city_id} #{city_map[city_id]}"
  puts 'old: '
  olds = Cata.where(cata_type: 'old').where("shop_id in (select shop_id from shops where city_id = #{city_id})").group_by(&:name)
  olds_names = olds.keys
  olds.each do |k,v|
    puts "#{k}: #{v.count}"
  end  

  puts ""

  puts 'new:'
  Cata.where(cata_type: 'new').where("shop_id in (select shop_id from shops where city_id = #{city_id})").group_by(&:name).each do |k,v|
    puts "#{k}: #{v.count} #{"(new)" unless olds_names.include?(k)}"
  end  
end