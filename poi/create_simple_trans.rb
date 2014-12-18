#coding:utf-8
require_relative 'shop'

dp_cata = DpCityCuisine.select(:cata_name).uniq.map{|dcc| dcc.cata_name }

Cuisine.where("id > 174").each do |cu|
  trans_cata = {}
  dp_cata.each do |ca|
    unless cu.keyword.blank?
      if cu.keyword.to_s.match(/#{ca}/) || ca.match(/#{cu.keyword}/)
        trans_cata['keyword'] = trans_cata['keyword'].to_a + [ca]
      end 
    end 

    unless cu.keyword_v2.blank?
      if cu.keyword_v2.to_s.match(/#{ca}/) || ca.match(/#{cu.keyword_v2}/)
        trans_cata['keyword_v2'] = trans_cata['keyword_v2'].to_a + [ca]
      end
    end  

    unless cu.keyword_v3.blank?
      if cu.keyword_v3.to_s.match(/#{ca}/) || ca.match(/#{cu.keyword_v3}/)
        trans_cata['keyword_v3'] = trans_cata['keyword_v3'].to_a + [ca]
      end
    end  
  end

  # unless trans_cata.blank?
    cu.simple_trans = trans_cata.sort.to_h.to_s
    cu.save
  # end  
end  
