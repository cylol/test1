#coding:utf-8
require 'nokogiri'
require 'json'
require 'logger'
require 'debugger'

class ShopParser
  attr_accessor :shop, :doc

  def initialize(id, html)
    @id = id
    @html = html
    @doc = Nokogiri::HTML(@html)
    @shop = Shop.new
    @shop.id = @id
  end 

  def parse
    if @doc.xpath("//td[@class='vspace150']").text.include?('已停业')
      @shop.shutdown = true
    end  
    @doc.xpath("//table[@bgcolor='#f3f3f3']//table//tr").each do |n|
      childrens = n.children
      next if childrens[0].text.nil? || childrens[0].text.strip == ""
      parse_main_info(childrens)
      parse_else
    end
  end

  def parse_else
    @shop.collectors_total = @doc.xpath("//span[@class='size12']")[0].text.delete("()")
  end  

  def parse_main_info(childrens)
    case childrens[0].text.strip
    when "店名"
      @shop.name = childrens[2].text
    when "地址"
      childrens[2].text.split(/\t|\n/).select{|e| e != "" }.each_slice(2).to_a.each do |c|
        if c[0].match(/地段名地址/)
          @shop.area_address = c[1][0..(c[1].index('(')-1)].delete("\n\t")
          @shop.area_address_ko = c[1][(c[1].index('(')+1)..-2].delete("\n\t")
        elsif c[0].match(/道路名地址/)
          @shop.street_address = c[1][0..(c[1].index('(')-1)].delete("\n\t")
          @shop.street_address_ko = c[1][(c[1].index('(')+1)..-2].delete("\n\t")
        else
          logger.debug("#{id} some new address value: #{childrens[0].text.strip}")  
        end    
      end
    when "联系电话"
      @shop.phone = childrens[2].text.delete("\n\t")
    when "邮箱"
      @shop.email = childrens[2].text.delete("\n\t")
    when "营业时间"
      @shop.hours = childrens[2].text.delete("\n\t")
    when "休息日"
      @shop.rest_days = childrens[2].text.delete("\n\t")
    when "中文服务"
      @shop.has_chinese_service = childrens[2].text.delete("\n\t")
    when "支付方式"
      @shop.Payment = childrens[2].text.delete("\n\t")
    when "交通"
      @shop.transit = childrens[2].text.delete("\n\t")
    when "网址"
      @shop.website = childrens[2].text.delete("\n\t")
    when "详细信息"
      @shop.description = childrens[2].text.delete("\n\t")
    when "分店信息"  
      @shop.branch = childrens[2].text.delete("\n\t")
    when "费用"
      @shop.cost = childrens[2].text.delete("\n\t")
    else
      logger.debug("#{@id} some new value: #{childrens[0].text.strip}")  
    end  
  end 

  def logger
    @logger ||= Logger.new('tiparser.log')
  end 
end  

class ShopParserT2 < ShopParser
  def parse
    @shop.name = @doc.xpath("//a[@class='item_subj']").text
    @shop.type = @doc.xpath("//div[@class='item_cat']").text 
    @shop.phone = @doc.xpath("//div[@class='iitem itel_forum']").text
    @shop.area_address = @doc.xpath("//div[@class='iitem iaddr_forum']").text    
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
    :type

  def to_json
    Hash[ self.instance_variables.map { |v| [v, instance_variable_get(v)] } ].to_json
  end
end  
