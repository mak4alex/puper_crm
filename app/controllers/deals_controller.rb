class DealsController < ApplicationController
  def new
    @deal = Deal.new
  end

  def create
    @deal = Deal.new(deal_params)
    if @deal.save
      redirect_to controller: @deal.type.underscore.pluralize, action: 'index'
    else
      render 'new'
    end
  end

  private

    def deal_params
      params.require(:deal).permit( :type, :sku, :name, :promo, :currency_id,
        :unit_type, :unit_price, :promo_unit_price, :description )
    end


end
