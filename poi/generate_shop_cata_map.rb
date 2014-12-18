require_relative 'shop'

puts Time.now

Shop.find_each(batch_size: 1000).each do |shop|
# Shop.where(shop_id: [2664097, 3339942]).each do |shop|
  # byebug
  cuisine_ids = ShopsCuisine.where(shop_id: shop.id).pluck(:cuisine_id)

  maps = {}
  map_v1s = {}

  ccs = cuisine_ids.map{|c_id| Shop.cityscuisines[[shop.city_id, c_id]] }

  shop.map = ccs.map{|cs| cs['map']}.reduce({}) do |h,pairs| 
    pairs.each {|k,v| (h[k] ||= []) << v} unless pairs.blank?
    h
  end


  shop.map_v1 = ccs.map{|cs| cs['map_v1']}.reduce({}) do |h,pairs| 
    pairs.each {|k,v| (h[k] ||= []) << v} unless pairs.blank?
    h
  end 

  # byebug

  if shop.map['keyword'].present?
    shop.map_level = 1
  elsif shop.map['keyword_v2'].present?
    shop.map_level = 2
  elsif shop.map['keyword_v3'].present?
    shop.map_level = 3
  else
    shop.map_level = 10
  end      
  
  shop.save

  if shop.map_level > 2
    if shop.map_v1['keyword'].present?
      shop.map_v1['keyword'].each{|w| shop.shops_cuisine_refs.create(name: w, level: 1) unless w.blank? }
    end

    if shop.map_v1['keyword_v2'].present?
      shop.map_v1['keyword_v2'].each{|w| shop.shops_cuisine_refs.create(name: w, level: 2) unless w.blank? }
    end
  end  
end  

puts Time.now