require 'httparty'
require 'logger'
require 'fileutils'
require 'debugger'
require_relative '../header'

class Openrice

  def initialize(id)
    @id = id 
  end

  def init_folder
    ['detail', 'map'].each{|k| FileUtils.mkdir_p("data/#{k}") }
  end  

  def download
    begin
      response = HTTParty.get("http://m.openrice.com/zh/restaurant/#{@id}", headers: Header.mobile )
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
      logger.error("#{e} with id #{@id}")
    end
  end

  def downloadmap
    begin
      response = HTTParty.get("http://m.openrice.com/zh/restaurant/map/#{@id}?tc=Sr2", headers: Header.mobile )
      # debugger
      if response.code != 200
        logger_map.debug("#{@id} not 200")
        return false
      else
        f = File.new("data/map/#{@id}", 'w')
        f.puts response.body
        f.close
        return true
      end
    rescue => e
      logger_map.error("#{e} with id #{@id}")
    end
  end  

  def logger
    @logger ||= Logger.new('openrice.log')
  end

  def logger_map
    @logger_map ||= Logger.new('map.log')
  end  
end 