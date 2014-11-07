#coding:utf-8
require 'nokogiri'
require 'json'
require 'logger'
require 'uri'
require 'cgi'
 

class ShopParser
  attr_accessor :shop, :doc, :poid

  def initialize(id, html, poih)
    @id = id.delete("\n")
    @html = html
    @doc = Nokogiri::HTML(@html)
    @poih = poih
    @poid = Nokogiri::HTML(@poih)
    @shop = Shop.new
    @shop.id = @id
  end 

  def parse
    begin
      @shop.name =  @doc.xpath("//div[@class='rest-title-label']").text.strip
      @shop.phone = @doc.xpath("//img[@src='/content/or/images/icon_info_photo_number@2x.png']/..").text.strip
      @shop.tags = @doc.xpath("//img[@src='/content/or/images/icon_info_type@2x.png']/..").text.strip
      @shop.cost = @doc.xpath("//img[@src='/content/or/images/icon_info_price@2x.png']/..").text.strip
      @shop.star = @doc.xpath("//img[@src='/content/or/images/icon_info_overall@2x.png']/..").text.strip.split(' ')[-1]
      @shop.review_totol = @doc.xpath("//div[@id='divReview']//span[@class='tabnumber']").text
      @doc.xpath("//div[@class='sr2-moresetail']//li").each do |li|
        parse_description(li)
      end
      url = @poid.xpath("//a[@id='aDirection']").attr('href')
      co = CGI.parse(URI.parse(url).query)['daddr'][0]
      @shop.longitude = co.split(',')[0]
      @shop.latitude = co.split(',')[-1]
    rescue => e
      logger.error("#{@id} with e")
    end  
  end

  def parse_description(li)
    detail_texts = li.children.map{|c| c.text.strip}.select{|x| x != "" }
    case detail_texts[0]
    when "招牌菜"
      @shop.specialty = detail_texts[1]
    when "推薦菜色"
      @shop.recommendation = detail_texts[1]
    when "營業時間"
      @shop.hours = detail_texts[1]
    when "付款方式"
      @shop.Payment = detail_texts[1]
    when "餐廳介紹"
      @shop.description = detail_texts[1]  
    end      
  end  

  def coordinate(url)
    co = CGI.parse(URI.parse(url).query)["center"][0]
    @shop.longitude = co.split(',')[0]
    @shop.latitude = co.split(',')[-1]
  end
    
  def logger
    @logger ||= Logger.new('tiparsererr.log')
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
    :latitude,
    :specialty,
    :recommendation

  def to_json
    Hash[ self.instance_variables.map { |v| [v, instance_variable_get(v)] } ].to_json
  end
end  



# @doc = Nokogiri::HTML(File.read(Dir["*"][30]))
