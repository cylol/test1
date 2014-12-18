require_relative 'shop'

puts Time.now

Shop.find_each(batch_size: 1000).each do |shop|
# Shop.where(shop_id: [2664097, 3339942]).each do |shop|
  # byebug
  # cuisine_ids = ShopsCuisine.where(shop_id: shop.id).pluck(:cuisine_id)

  # maps = {}
  # map_v1s = {}

  # ccs = cuisine_ids.map{|c_id| Shop.cityscuisines[[shop.city_id, c_id]] }

  # shop.map = ccs.map{|cs| cs['map']}.reduce({}) do |h,pairs| 
  #   pairs.each {|k,v| (h[k] ||= []) << v} unless pairs.blank?
  #   h
  # end


  # shop.map_v1 = ccs.map{|cs| cs['map_v1']}.reduce({}) do |h,pairs| 
  #   pairs.each {|k,v| (h[k] ||= []) << v} unless pairs.blank?
  #   h
  # end 

  # # byebug

  # if shop.map['keyword'].present?
  #   shop.map_level = 1
  # elsif shop.map['keyword_v2'].present?
  #   shop.map_level = 2
  # elsif shop.map['keyword_v3'].present?
  #   shop.map_level = 3
  # else
  #   shop.map_level = 10
  # end      
  
  # shop.save

  # if shop.map_level > 2
  #   if shop.map_v1['keyword'].present?
  #     shop.map_v1['keyword'].each{|w| shop.shops_cuisine_refs.create(name: w, level: 1) unless w.blank? }
  #   end

  #   if shop.map_v1['keyword_v2'].present?
  #     shop.map_v1['keyword_v2'].each{|w| shop.shops_cuisine_refs.create(name: w, level: 2) unless w.blank? }
  #   end
  # end  

  next if shop.map_level > 3 && shop.map_v1.blank?
  if shop.map_level == 1
    shop.map['keyword'].flatten.uniq.each{|k| shop.catas.create(name: k, cata_type: 'old')}
    shop.map['keyword'].flatten.uniq.each{|k| shop.catas.create(name: k, cata_type: 'new')}
  elsif shop.map_level == 2
    shop.map['keyword_v2'].flatten.uniq.each{|k| shop.catas.create(name: k, cata_type: 'old')}
    if shop.map_v1['keyword'].blank? || CitysNewCuisine.where(city_id: shop.city_id, name: shop.map_v1['keyword'].flatten.uniq ).blank?
      shop.map['keyword_v2'].flatten.uniq.each do |k|
        shop.catas.create(name: k, cata_type: 'new') unless k.blank?
      end
    else
      shop.map_v1['keyword'].flatten.uniq.each do |k|
        unless CitysNewCuisine.where(city_id: shop.city_id, name: k).blank?
          shop.catas.create(name: k, cata_type: 'new') unless k.blank?
        end
      end
    end
  else
    if shop.map['keyword_v3'].blank?
      shop.catas.create(name: '其他美食', cata_type: 'old')
    else  
      shop.catas.create(name: shop.map['keyword_v3'].flatten[0], cata_type: 'old')
    end
    if !shop.map_v1['keyword'].blank? && !CitysNewCuisine.where(city_id: shop.city_id, name: shop.map_v1['keyword'].flatten.uniq ).blank?
      shop.map_v1['keyword'].flatten.uniq.each do |k|
        unless CitysNewCuisine.where(city_id: shop.city_id, name: k).blank?
          shop.catas.create(name: k, cata_type: 'new') unless k.blank?
        end  
      end
    elsif !shop.map_v1['keyword_v2'].blank? && !CitysNewCuisine.where(city_id: shop.city_id, name: shop.map_v1['keyword_v2'].flatten.uniq).blank?
      shop.map_v1['keyword_v2'].flatten.uniq.each do |k|
        unless CitysNewCuisine.where(city_id: shop.city_id, name: k).blank?
          shop.catas.create(name: k, cata_type: 'new') unless k.blank?
        end  
      end
    else  
      if shop.map['keyword_v3'].blank?
        shop.catas.create(name: '其他美食', cata_type: 'new')
      else  
        shop.catas.create(name: shop.map['keyword_v3'].flatten[0], cata_type: 'new')
      end
    end
  end  
end  

puts Time.now