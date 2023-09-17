class StocksController < ApplicationController
  def price
    indices = params[:indices]

    if indices.blank?
      render json: { error: 'Indices parameter is missing.' }, status: :bad_request
      return
    end

    begin
      client = LatestStockPrice::Client.new
      data = client.price(indices)
      render json: { data: data }, status: :ok
    rescue => e
      render json: { error: e.message }, status: :internal_server_error
    end
  end

  def price_all
    begin
      client = LatestStockPrice::Client.new
      data = client.price_all()
      render json: { data: data }, status: :ok
    rescue => e
      render json: { error: e.message }, status: :internal_server_error
    end
  end
end
