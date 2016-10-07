class SupplierDealsController < ApplicationController
  def index
    @supplier_deals = SupplierDeal.all
  end

  def show
  end
end
