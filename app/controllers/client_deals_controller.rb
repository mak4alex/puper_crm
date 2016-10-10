class ClientDealsController < ApplicationController
  def index
    @client_deals = ClientDeal.all
  end

  def show
  end
end
