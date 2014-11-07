require_relative 'request'

Openrice.new(nil).init_folder

logger = Logger.new('systemmap.log')

threads = []


(0..1).map do |r|
  (0..19).map do |t|
    # debugger
    # ((t * 50 + 1000 * r )..(t + 1) * 50 + 1000 * r - 1).each{|num| Openrice.new(num).downloadmap }
    threads << Thread.new { ((t * 50 + 1000 * r )..(t + 1) * 50 + 1000 * r - 1).each{|num| Openrice.new(num).downloadmap } }
  end

  logger.info "#{r} #{threads}"
  threads.each { |thread| thread.join }
  logger.info "#{r} #{threads} ends"
  threads = []
end  