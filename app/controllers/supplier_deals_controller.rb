class SupplierDealsController < ApplicationController
  def index
    @supplier_deals = SupplierDeal.all
  end

  def show
    @supplier_deal = SupplierDeal.find(params[:id])
  end
end
