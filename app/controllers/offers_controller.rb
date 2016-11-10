class OffersController < ApplicationController

  def index
    @offers = Offer.includes(:agent, :deal).all
  end

  def create
    offer = Offer.new(offer_params)
    if offer.save
      OffersMailer.distribute(offer).deliver_now      
    end
    redirect_back(fallback_location: root_path)
  end

  private

    def offer_params
      params.require(:offer).permit(:type, :deal_id, :agent_id)
    end

end
