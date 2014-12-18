require_relative 'shop'


Tashop.find_each(batch_size: 1000).each do |tshop|
  tshop.generate_shop_record
end  

