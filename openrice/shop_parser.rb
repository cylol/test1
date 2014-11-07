#coding:utf-8
require 'nokogiri'
require 'json'
require 'logger'
require 'debugger'
require 'URI'
require 'cgi'

class ShopUrlParser
  def initialize(path, html)
    @html = html
    @path = path
    @doc = JSON(@html)
  end

  def parse
    f = File.new("data/detail/#{@path}", 'w')
    @doc["search_map"]["markers"].values.map{|c| c["url"] }.each do |url|
      f.puts url
    end  
    f.close
  end  
end  

class ShopParser
  attr_accessor :shop, :doc

  def initialize(id, html)
    @id = id.delete("\n")
    @html = html
    @doc = Nokogiri::HTML(@html)
    @shop = Shop.new
    @shop.id = @id
  end 

  def parse
    @shop.name = @doc.xpath("//h1").text.strip
    @shop.phone = @doc.xpath("//span[@class='biz-phone']").text.strip
    @shop.website = @doc.xpath("//div[@class='biz-website']/a").text.strip
    @shop.area_address = @doc.xpath("//address")[0].text.strip
    @shop.tags = @doc.xpath("//span[@class='category-str-list']/a").map{|n| n.text}.join(',')
    @shop.star = @doc.xpath("//div[@itemprop='aggregateRating']//meta").attr('content').value rescue ""
    @shop.cost = @doc.xpath("//span[@class='bullet-after']/span[@class='business-attribute price-range']").text
    coordinate(@doc.xpath("//img[@alt='Map']")[0].attr('src'))
  end

  def coordinate(url)
    co = CGI.parse(URI.parse(url).query)["center"][0]
    @shop.longitude = co.split(',')[0]
    @shop.latitude = co.split(',')[-1]
  end
    
  def logger
    @logger ||= Logger.new('tiparser.log')
  end 
end   

class Shop
  attr_accessor :id,
    :name, 
    :phone,
    :area_address,
    :area_address_ko,
    :street_address,
    :street_address_ko,
    :email,
    :hours,
    :rest_days,
    :has_chinese_service,
    :Payment,
    :transit,
    :website,
    :description,
    :tags,
    :review_totol,
    :collectors_total,
    :branch,
    :cost,
    :shutdown,
    :type,
    :file,
    :star,
    :longitude,
    :latitude

  def to_json
    Hash[ self.instance_variables.map { |v| [v, instance_variable_get(v)] } ].to_json
  end
end  



# @doc = Nokogiri::HTML(File.read(Dir["*"][30]))
