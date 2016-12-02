# A small class to wrap up the Rollbar API endpoint
module Rollbar
  class API
    BASE_URL = 'https://api.rollbar.com/api/1/'.freeze

    def self.request(*args)
      new(ENV['ROLLBAR_API_ACCESS_TOKEN']).request(*args)
    end

    def initialize(access_token)
      @access_token = access_token
    end

    def request(path, params = {})
      url = BASE_URL + path

      params.reject! { |_key, value| value.blank? }
      params['access_token'] = access_token
      uri = URI.parse(url)
      uri.query = URI.encode_www_form(params)

      JSON.parse(http_request(uri).body)
    end

    private

    attr_reader :access_token

    def http_request(uri)
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true

      request = Net::HTTP::Get.new(uri)
      response = http.request(request)

      raise "Bad response from Buildkite: #{response.code}" unless response.code == '200'
      response
    end
  end
end
