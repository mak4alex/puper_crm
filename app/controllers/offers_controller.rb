class OffersController < ApplicationController

  def new_for_client
    @offer = ClientOffer.new
  end

  def new_for_supplier
    @offer = SupplierOffer.new
  end

  def create
  end

end
