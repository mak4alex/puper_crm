class ClientsController < ApplicationController
  def index
    @clients = Client.includes(:contact, :manager).all
  end

  def show
    @client = Client.find(params[:id])
  end
end
