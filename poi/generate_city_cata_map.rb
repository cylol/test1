require_relative 'shop'

CitysCuisine.all.each do |cu|
  trans_cata = {}

  DpCityCuisine.where(city_id: cu.city_id).each do |ca|
    unless cu.cuisine.keyword.blank?
      if ca.cata_name.match(/#{cu.cuisine.keyword}/)
        # byebug
        trans_cata['keyword'] = trans_cata['keyword'].to_a + [ca.cata_name]
      end 
    end 

    unless cu.cuisine.keyword_v2.blank?
      if ca.cata_name.match(/#{cu.cuisine.keyword_v2}/)
        # byebug
        trans_cata['keyword_v2'] = trans_cata['keyword_v2'].to_a + [ca.cata_name]
      end
    end  

    unless cu.cuisine.keyword_v3.blank?
      if ca.cata_name.match(/#{cu.cuisine.keyword_v3}/)
        # byebug
        trans_cata['keyword_v3'] = trans_cata['keyword_v3'].to_a + [ca.cata_name]
      end
    end  

  # unless trans_cata.blank?
    # byebug

  # end  
  end
  cu.map = trans_cata.sort.to_h

  if trans_cata['keyword'].blank? && trans_cata['keyword_v2'].blank? && !cu.cuisine.keyword.blank?
    cu.map_v1 = { "keyword" => cu.cuisine.keyword,  "keyword_v2" => cu.cuisine.keyword_v2, "keyword_v3" => cu.cuisine.keyword_v3 }
  end  
  cu.save
end 