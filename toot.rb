require 'net/http'
require 'uri'
require 'json'


def PostToot (vis, cw, account, body)
  uri = URI.parse(account[:host])
  https = Net::HTTP.new(uri.host, uri.port)
  https.use_ssl = true

  req = Net::HTTP::Post.new(uri.request_uri)

  data = {
            status: body,
            visibility: vis,
            spoiler_text: cw
  }.to_json


  token = " Bearer " + account[:token]

  req["Content-Type"] = "application/json"
  req["Authorization"] = token

  req.body = data

  res = https.request(req)

  $http_status_code = "code -> #{res.code}"
  $http_msg = "msg -> #{res.message}"
  $http_body = "body -> #{JSON.parse(res.body)}"
end
