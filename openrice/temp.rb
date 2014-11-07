require 'logger'

logger = Logger.new('diff.log')

d = Dir['data/detail/*'].map{|f| f.split('/')[-1] }
m = Dir['data/map/*'].map{|f| f.split('/')[-1] }

puts '--------------------------------------'

logger.info (d - m) 

puts '--------------------------------------'

logger.info (m - d)

puts (d - m).count
puts (m - d).count
