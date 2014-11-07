require_relative 'request'

Openrice.new(nil).init_folder

logger = Logger.new('system.log')

threads = []

(0..40).map do |r|
  (0..9).map do |t|
    threads << Thread.new { ((t * 100 + 1000 * r )..(t + 1) * 100 + 1000 * r - 1).each{|num| Openrice.new(num).download } }
  end

  logger.info "#{r} #{threads}"
  threads.each { |thread| thread.join }
  logger.info "#{r} #{threads} ends"
  threads = []
end  