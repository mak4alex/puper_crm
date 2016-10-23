class ClientDealsController < ApplicationController
  def index
    @client_deals = ClientDeal.all
  end

  def show
    @client_deal = ClientDeal.find(params[:id])
  end
end
