# http://www.yelp.com/search?cflt=restaurants#find_desc&find_loc=New+York,+NY&start=0&attrs=RestaurantsPriceRange2.4
require 'httparty'
require 'logger'
require 'fileutils'
require 'debugger'
require_relative '../header'

class Yelp
  CATEGROYS = { 
    'p1' => 'RestaurantsPriceRange2.1',
    'p2' => 'RestaurantsPriceRange2.2',
    'p3' => 'RestaurantsPriceRange2.3',
    'p4' => 'RestaurantsPriceRange2.4'
  }

  SIZE_404 = 1000

  # def initialize(id)
  #   @id = id 
  # end

  def init_folder
    (CATEGROYS.keys + ['error', 'detail', 'detaili']).each{|k| FileUtils.mkdir_p("data/#{k}") }
  end  

  def download_cata(start, price)
    begin
      header = Header.mac 
      # url = "http://www.yelp.com/search?cflt=restaurants#find_desc&find_loc=New+York,+NY&start=#{start}&attrs=#{CATEGROYS[price]}"
      url = "http://www.yelp.com/search/snippet?find_desc&find_loc=New%20York%2C%20NY&start=#{start}&cflt=restaurants&attrs=#{CATEGROYS[price]}&parent_request_id=1ab32224bcdc5a4d&request_origin=user"
      puts url
      response = HTTParty.get(url, headers: header )
      if response.body.length < SIZE_404
        logger_catalog.debug("#{start} with #{price} with #{header} 404")
        f = File.new("data/error/#{price}_#{start}", 'w')
        f.puts response.body
        f.close
        return false
      else
        # logger_catalog.debug("#{start} with #{price} with #{header} not404")
        f = File.new("data/#{price}/#{start}", 'w')
        f.puts response.body
        f.close
        return true
      end
    rescue => e
      logger_catalog.error("#{e} with #{start} with #{price}")
    end
  end 

  def download_info(url, cata)
    begin
      header = Header.mac 
      response = HTTParty.get("http://www.yelp.com/#{url}", headers: header )
      if response.size < SIZE_404
        logger_catalog.debug("#{url} with #{header} detail 404")
        f = File.new("data/error/#{cata}_#{path.gsub('/', '_')}", 'w')
        f.puts response.body
        f.close
        return false
      else
        # logger_catalog.debug("#{path} with #{header} detail not404")
        f = File.new("data/detaili/#{cata}_#{url.gsub('/', '_')}", 'w')
        f.puts response.body
        f.close
        return true
      end
    rescue => e
      logger_catalog.error("#{e} with #{url} with #{header}")
    end
  end  

  def logger_catalog
    @logger_catalog ||= Logger.new('yelpcatalog.log')
  end 
end


# 
# debugger
# Yelp.new.init_folder

# ['p4'].each do |p|
# (0..99).each{|n| Yelp.new.download_cata(10 * n, p) }
# end
# require 'json'

# b = []
# Dir["*"].each do |f|
#   begin
#   b.push JSON(File.read(f))["search_map"]["markers"].values.map{|c| c["url"] }
#   rescue
#     puts f
#     break
#   end
# end  