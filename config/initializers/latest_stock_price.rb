require 'latest_stock_price'

LatestStockPrice.configure do |config|
  config.api_key = ENV['LATEST_STOCK_PRICE_API_KEY']
end
