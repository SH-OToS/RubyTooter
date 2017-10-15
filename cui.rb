require 'optparse'
require './toot.rb'



vis = "unlisted"
cw = ""

account = {
  :token => "",
  :host => ""
}

account[:host] = "https://" + account[:host] + "/api/v1/statuses"

OptionParser.new do |opt|
  opt.on('--pb',            'Specify visibility as public'                      ) { vis = "public" }
  opt.on('--ul',            'Specify visibility as unlisted'                    ) { vis = "unlisted" }
  opt.on('--pv',            'Specify visibility as private'                     ) { vis = "private" }
  opt.on('--di',            'Specify visibility as direct'                      ) { vis = "direct" }
  opt.on('--cw [TEXT]',     'Use CW. Please Input CW Text for After this option') { |v| cw = "#{v}" }

  opt.parse!(ARGV)
end


if ARGV[0].nil? || ARGV[0].empty? then
  puts "Error: ARGV[0] is empty!"
  exit!
end 

body = ARGV[0]


PostToot(vis, cw, account, body)

puts $http_status_code
puts $http_msg
puts $http_body
