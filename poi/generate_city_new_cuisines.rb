require_relative 'shop'

city_ids = Shop.select(:city_id).uniq.map{|s| s.city_id }

# byebug

city_ids.each do |city_id|
  city_shop_count =  Shop.where(city_id: city_id).count
  limit = [[1000, (city_shop_count * 0.05).to_i].min, 10].max
  city_refs = ShopsCuisineRef.where(shop_id: Shop.where(city_id: city_id)).group_by(&:name)
  city_refs.each do |k, v|
    if v.count > limit
      CitysNewCuisine.create(city_id: city_id, name: k)
    end
  end
end      

1