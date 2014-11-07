require 'httparty'
require 'logger'
require 'fileutils'
require_relative '../header'

class Konest

  CATEGROYS = { 
    'food' => '/contents/food_detail.html?id=',
    'shop' => '/contents/shop_detail.html?id=',
    'spot' => '/contents/spot_detail.html?id=',
    'clinic' => '/contents/clinic_detail.html?id='
  }

  SIZE_404 = 10000

  def initialize(id)
    @id = id 
  end

  def init_folder
    (CATEGROYS.keys + ['t2', 't3']).each{|k| FileUtils.mkdir_p("data/#{k}") }
  end  

  def download_t1
    CATEGROYS.each do |catagroy, url|
      begin
        response = HTTParty.get("http://cn.konest.com/#{url}#{@id}", headers: Header.random )
        if response.size < SIZE_404
          logger_t1.debug("#{@id} with #{catagroy} 404")
          next
        else
          f = File.new("data/#{catagroy}/#{@id}", 'w')
          f.puts response.body
          f.close
          return true
        end
      rescue => e
        logger_t1.error("#{e} with id #{@id}")
      end
    end

    logger_t1.info("#{@id} is empty.")
  end 

  # 1~9000
  def download_t2
    begin
      response = HTTParty.get("http://map.cn.konest.com/dforum/#{@id}", headers: Header.random )
      if response.size < SIZE_404
        return false
      end  
      f = File.new("data/t2/#{@id}", 'w')
      f.puts response.body
      f.close
      logger_t2.info("#{@id} not empty.")
      return true
    rescue 
      logger_t2.info("#{@id} is empty.")
    end  

  end
  
  # 100000000~101600000
  def download_t3
    begin
      response = HTTParty.get("http://map.cn.konest.com/dpoi/#{@id}", headers: Header.random )
      if response.size < SIZE_404
        return false
      end       
      f = File.new("data/t3/#{@id}", 'w')
      f.puts response.body
      f.close
      logger_t3.info("#{@id} not empty.")
      return true
    rescue 
      logger_t3.info("#{@id} is empty.")
    end    
  end  

  def logger_t1
    @logger_t1 ||= Logger.new('konest1.log')
  end

  def logger_t2
    @logger_t2 ||= Logger.new('konest2.log')
  end

  def logger_t3
    @logger_t3 ||= Logger.new('konest3.log')
  end  
end 