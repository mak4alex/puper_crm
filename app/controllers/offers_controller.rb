class OffersController < ApplicationController

  before_action :new_offer, only: [:new_for_client, :new_for_supplier]

  def index
    @offers = Offer.includes(:agent, :deal).all
  end

  def new_for_client
  end

  def new_for_supplier
  end

  def create
    offer = Offer.new(offer_params)
    if offer.save
      OffersMailer.distribute(offer).deliver_now
      redirect_to offers_url
    else
      render(offer.type == 'ClientOffer' ? 'new_for_client' : 'new_for_supplier')
    end
  end

  private

    def offer_params
      params.require(:offer).permit(:type, :deal_id, :agent_id)
    end

    def new_offer
      @offer = Offer.new
    end

end
