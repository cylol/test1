require 'httparty'
require 'logger'
require 'fileutils'
require_relative '../header'

class TimeSq

  def initialize(id)
    @id = id 
  end

  def init_folder
    ['detail', 'map'].each{|k| FileUtils.mkdir_p("data/#{k}") }
  end

  def download_images
    ((1..9).to_a + ['b1', 'b2']).each do |b|
      File.open("data/pic/f#{b}.jpg", "wb") do |f| 
        f.write HTTParty.get("http://www.timessquare.com.hk/images/floorplan/f#{b}.png").parsed_response
      end
    end  
  end

  def download_cata(c_id)
    cat = c_id.nil? ? "" : "?cat=#{c_id}"
    File.open("data/map/#{c_id || "all"}", "w") do |f| 
      f.write HTTParty.get("http://www.timessquare.com.hk/eng/shopping_list_side.php#{cat}").body
    end
  end

  def download
    begin
      response = HTTParty.get("http://www.timessquare.com.hk/eng/shop_detail.php?shop=#{@id}", headers: Header.mobile )
      if response.code != 200
        logger.debug("#{@id} not 200")
        return false
      else
        f = File.new("data/detail/#{@id}", 'w')
        f.puts response.body
        f.close
        return true
      end
    rescue => e
      logger.error("#{e} detail with id #{@id}")
    end
  end

  def downloadmain
    begin
      response = HTTParty.get("http://www.timessquare.com.hk/eng/shopping_list.php", headers: Header.mobile )
      # debugger
      if response.code != 200
        logger_map.debug("downloadmain not 200")
        return false
      else
        f = File.new("data/main", 'w')
        f.puts response.body
        f.close
        return true
      end
    rescue => e
      logger_map.error("#{e} with downloadmain ")
    end
  end  

  def logger
    @logger ||= Logger.new('openrice.log')
  end

  def logger_map
    @logger_map ||= Logger.new('map.log')
  end  
end 


