require 'net/http'
require 'json'

module LatestStockPrice
  class Client
    BASE_URL = "https://latest-stock-price.p.rapidapi.com".freeze

    def initialize
      @api_key = LatestStockPrice.configuration.api_key
      @headers = {
        "X-RapidAPI-Host" => "latest-stock-price.p.rapidapi.com",
        "X-RapidAPI-Key" => @api_key,
      }
    end

    def price(indices)
      request("/price?Indices=#{indices}")
    end

    def price_all
      request("/any")
    end

    private

    def request(path)
      uri = URI("#{BASE_URL}#{path}")
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true

      request = Net::HTTP::Get.new(uri, @headers)
      response = http.request(request)
      
      if response.is_a?(Net::HTTPSuccess)
        JSON.parse(response.body)
      else
        # Handle error appropriately
        { error: response.body }
      end
    end
  end
end
