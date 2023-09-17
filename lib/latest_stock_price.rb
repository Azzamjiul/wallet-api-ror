require_relative 'latest_stock_price/version'
require_relative 'latest_stock_price/configuration'
require_relative 'latest_stock_price/client'

module LatestStockPrice
  class << self
    attr_writer :configuration
  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.reset
    @configuration = Configuration.new
  end

  def self.configure
    yield(configuration)
  end
end
