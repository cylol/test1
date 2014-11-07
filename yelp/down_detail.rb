require_relative 'request'


threads = []

def par(n)
  Dir["data/detail/p#{n}_*"].each do |file|
    # next if file.start_with?("data/detail/p1_1") or file.start_with?("data/detail/p1_0")
    puts file
    $stdout.flush
    urls = File.read(file).lines
    path = file[5..-1].gsub('/','_')
    # puts path
    urls.each do |url|
      # ShopUrlParser.new(path, html).parse
      Yelp.new.download_info(url, path)
    end
  end  
end

(1..4).each do |n|
  threads << Thread.new { par(n) }
end

threads.each { |thread| thread.join }

