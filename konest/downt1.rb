require_relative 'request'

Konest.new(0).init_folder

logger = Logger.new('system.log')

threads = []

(1..10).each do |ran|
  Range.new((ran - 1)*1000 + 1, ran * 1000).each_slice(100).to_a.each do |nums|
    threads << Thread.new { nums.each{|num| Konest.new(num).download_t1 } }
  end

  logger.info "t1 #{} #{threads}"
  threads.each { |thread| thread.join }
  logger.info "t1 #{threads} ends"
  threads = []
end
