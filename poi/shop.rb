    # info.append(self.cityId)
    # info.append(self.shopId)
    # info.append(self.name)
    # info.append(self.address)
    # info.append(self.addressHtml)
    # info.append(self.phone)
    # info.append(self.latitude)
    # info.append(self.longitude)
    # info.append(self.reviewTotal)
    # info.append(self.star)
    # info.append(self.foodScore)
    # info.append(self.serviceScore)
    # info.append(self.valueScore)
    # info.append(self.atmosphereScore)
    # info.append(self.avgPrice)
    # info.append(self.cuisine)
    # info.append(self.hours)
    # info.append(self.goodFor)
    # info.append(self.diningOption)
    # info.append(self.diningStyle)
    # info.append(self.neighborhood)
    # info.append(self.crossStreet)
    # info.append(self.transit)
    # info.append(self.description)


 #coding:utf-8
require 'mysql2'
require 'active_record'
require 'date'
require 'byebug'
require 'logger'

ActiveRecord::Base.establish_connection(
  :encoding  => 'utf8',
  :adapter => "mysql2",
  :host => "127.0.0.1",
  :username => "root",
  :password => "",
  :database => "oversea"
)


$log = Logger.new('sys.log')

class ShopsNeighborhood < ActiveRecord::Base
  # accepts_nested_attributes_for :shop_id, :neighborhood_id

  belongs_to :shop
  belongs_to :neighborhood
end  

class ShopsCuisine < ActiveRecord::Base
  # accepts_nested_attributes_for :shop_id, :cuisine_id

  belongs_to :shop
  belongs_to :cuisine
end  

class ShopsGood < ActiveRecord::Base
  # accepts_nested_attributes_for :shop_id, :good_id

  belongs_to :shop
  belongs_to :good
end


class ShopsDiningoption < ActiveRecord::Base
  # accepts_nested_attributes_for :shop_id, :diningoption_id

  belongs_to :shop
  belongs_to :diningoption
end

class Neighborhood < ActiveRecord::Base
  # accepts_nested_attributes_for :name
end  


class Cuisine < ActiveRecord::Base
  # accepts_nested_attributes_for :name
end


class Good < ActiveRecord::Base
  # accepts_nested_attributes_for :name
end


class Diningoption < ActiveRecord::Base
  # accepts_nested_attributes_for :name
end

class Shop < ActiveRecord::Base
  self.primary_key = 'shop_id'
  # accepts_nested_attributes_for :city_id, :name, :address, :address_html, :phone, :latitude, :longitude, :review_total, :star, :food_score, :service_score,
  #   :value_score, :atmosphere_score, :avg_price, :hours

  has_many :shops_cuisines
  has_many :shops_goods
  has_many :shops_diningoptions
  has_many :shops_neighborhoods

  has_many :cuisines, through: :shops_cuisines
  has_many :goods, through: :shops_goods, foreign_key: :good_id
  has_many :diningoptions, through: :shops_diningoptions
  has_many :neighborhood, through: :shops_neighborhoods

  @@cuisines = Cuisine.all.map{|g| [g.name, g.id] }.to_h
  @@goods = Good.all.map{|g| [g.name, g.id] }.to_h
  @@diningoptions = Diningoption.all.map{|g| [g.name, g.id] }.to_h
  @@neighborhoods = Neighborhood.all.map{|g| [g.name, g.id] }.to_h


  def self.insert_shop(line)
    begin 
      ps = line.split('^')
      shop = Shop.new

      shop.shop_id = ps[1]
      shop.city_id = ps[0]
      shop.name = ps[2]
      shop.address = ps[3]
      shop.address_html = ps[4]
      shop.phone = ps[5]
      ll_att = ps[6].split(',')
      shop.latitude = ll_att[0]
      shop.longitude = ll_att[1]
      shop.star = ps[7]
      shop.review_total = ps[8]
      shop.avg_price = ps[9]
      shop.recomand_percent = ps[14]
      values = ps[16].split(',').map{|v| v.split(':')}

      values.each do |v|
        if v[0] == 'Food'
          shop.food_score = v[1]
        elsif v[0] == 'Service' 
          shop.service_score = v[1]
        elsif v[0] == 'Value'
          shop.value_score = v[1]
        elsif v[0] == 'Atmosphere'
          shop.atmosphere_score = v[1]
        end     
      end

      recomands = ps[15].split(',').map{|v| v.split(':')}


      recomands.each do |v|
        if v[0] == 'Excellent'
          shop.excellent = v[1]
        elsif v[0] == 'Very good' 
          shop.very_good = v[1]
        elsif v[0] == 'Average'
          shop.average = v[1]
        elsif v[0] == 'Poor'
          shop.poor = v[1]
        elsif v[0] == 'Terrible'
          shop.terrible = v[1] 
        end     
      end

      shop.save

      shop.insert_cuisines(ps[10])
      shop.insert_goods(ps[11])
      shop.insert_diningoptions(ps[12])
      shop.insert_neighborhoods(ps[13])
    rescue => e
      $log.error("#{shop.to_s} : #{e}")
    end  
  end  


  def insert_goods(goods_sting)
    good_names = goods_sting.split(',')
    good_names.map{|g| g.strip}.each do |good_name|
      if @@goods[good_name].blank?
        good = Good.find_or_create_by(name: good_name)
        @@goods[good.name] = good.id
      end
      ShopsGood.create(shop_id: self.id, good_id: @@goods[good_name])
    end
  end


  def insert_cuisines(goods_sting)
    good_names = goods_sting.split(',')
    good_names.map{|g| g.strip}.each do |good_name|
      if @@cuisines[good_name].blank?
        good = Cuisine.find_or_create_by(name: good_name)
        @@cuisines[good.name] = good.id
      end
      ShopsCuisine.create(shop_id: self.id, cuisine_id: @@cuisines[good_name])
    end
  end

  def insert_diningoptions(goods_sting)
    good_names = goods_sting.split(',')
    good_names.map{|g| g.strip}.each do |good_name|
      if @@diningoptions[good_name].blank?
        good = Diningoption.find_or_create_by(name: good_name)
        @@diningoptions[good.name] = good.id
      end
      ShopsDiningoption.create(shop_id: self.id, diningoption_id: @@diningoptions[good_name])
    end
  end

  def insert_neighborhoods(goods_sting)
    good_names = goods_sting.split(',')
    good_names.map{|g| g.strip}.each do |good_name|
      if @@neighborhoods[good_name].blank?
        good = Neighborhood.find_or_create_by(name: good_name)
        @@neighborhoods[good.name] = good.id
      end
      ShopsNeighborhood.create(shop_id: self.id, neighborhood_id: @@neighborhoods[good_name])
    end
  end

end


#     