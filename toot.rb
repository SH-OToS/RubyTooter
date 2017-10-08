require 'net/http'
require 'uri'
require 'json'
require 'optparse'

vis = "public"
cw = ""
token = ""
host = ''

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


URL = "https://" + host + "/api/v1/statuses"

uri = URI.parse(URL)
https = Net::HTTP.new(uri.host, uri.port)
https.use_ssl = true

req = Net::HTTP::Post.new(uri.request_uri)



data = {
          status: ARGV[0],
          visibility: vis,
          spoiler_text: cw
       }.to_json


token = " Bearer " + token

req["Content-Type"] = "application/json"
req["Authorization"] = token

req.body = data

res = https.request(req)

puts "code -> #{res.code}"
puts "msg -> #{res.message}"
puts "body -> #{JSON.parse(res.body)}"
