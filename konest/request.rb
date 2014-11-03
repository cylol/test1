require 'httparty'
require 'logger'
require 'fileutils'

class Header
  USER_AGENTS = [
    "Mozilla/5.0 (Macintosh; Intel Mac OS X 10.8; rv:21.0) Gecko/20100101 Firefox/21.0",
    "Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:21.0) Gecko/20130331 Firefox/21.0",
    "Mozilla/5.0 (Windows NT 6.2; WOW64; rv:21.0) Gecko/20100101 Firefox/21.0",
    "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_7_2) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/27.0.1453.93 Safari/537.36",
    "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/535.11 (KHTML, like Gecko) Ubuntu/11.10 Chromium/27.0.1453.93 Chrome/27.0.1453.93 Safari/537.36",
    "Mozilla/5.0 (Windows NT 6.2; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/27.0.1453.94 Safari/537.36",
    "Mozilla/5.0 (compatible; WOW64; MSIE 10.0; Windows NT 6.2)",
    "Mozilla/4.0 (Windows; MSIE 6.0; Windows NT 5.2)",
    "Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 6.0)",
    "Mozilla/4.0 (compatible; MSIE 8.0; Windows NT 6.0; Trident/4.0)",
    "Mozilla/5.0 (compatible; MSIE 9.0; Windows NT 6.1; Trident/5.0)",
    "Opera/9.80 (Macintosh; Intel Mac OS X 10.6.8; U; en) Presto/2.9.168 Version/11.52",
    "Opera/9.80 (Windows NT 6.1; WOW64; U; en) Presto/2.10.229 Version/11.62",
    "Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10_6_6; en-US) AppleWebKit/533.20.25 (KHTML, like Gecko) Version/5.0.4 Safari/533.20.27",
    "Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US) AppleWebKit/533.20.25 (KHTML, like Gecko) Version/5.0.4 Safari/533.20.27"
  ]

  HEADER = {
    'User-Agent' => 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/37.0.2062.94 Safari/537.36',
    'Accept' => 'text/html',
    'Accept-Language' => 'zh-CN',
    'Cache-Control' => 'no-cache',
    'Referer' => 'http://www.tripadvisor.com/',
    'X-Forwarded-For' => '127.0.0.1'
  }

  def self.random
    HEADER.merge('User-Agent' => USER_AGENTS.sample)
  end
    
end

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