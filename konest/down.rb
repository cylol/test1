require_relative 'request'

Konest.new(0).init_folder

logger = Logger.new('system.log')

threads = []

(1..10).each do |ran|
  Range.new((ran - 1)*1000 + 1, ran * 1000).each_slice(300).to_a.each do |nums|
    threads << Thread.new { nums.each{|num| Konest.new(num).download } }
  end

  logger.info "#{} #{threads}"
  threads.each { |thread| thread.join }
  logger.info "#{threads} ends"
  threads = []
end
