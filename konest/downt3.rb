require_relative 'request'

Konest.new(0).init_folder

logger = Logger.new('system.log')

threads = []

(1..16).each do |ran|
  Range.new(100000000 + (ran - 1)*100000 + 1, 100000000 + ran * 100000).each_slice(10000).to_a.each do |nums|
    threads << Thread.new { nums.each{|num| Konest.new(num).download_t3 } }
  end

  logger.info "t3 #{} #{threads}"
  threads.each { |thread| thread.join }
  logger.info "t3 #{threads} ends"
  threads = []
end
