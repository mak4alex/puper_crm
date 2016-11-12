class DealsController < ApplicationController

  def new
    @deal = Deal.new
  end

  def create
    @deal = Deal.new(deal_params)
    if @deal.save
      redirect_to controller: @deal.type.underscore.pluralize, action: 'show', id: @deal.id
    else
      render 'new'
    end
  end

  def import
    Deal.find(params[:id]).import(params)
    redirect_back(fallback_location: root_path)
  end

  def recalc
    Deal.find(params[:id]).recalc
    redirect_back(fallback_location: root_path)
  end

  private

    def deal_params
      params.require(:deal).permit( :type, :sku, :name, :promo, :currency_id,
        :unit_type, :unit_price, :promo_unit_price, :description, :start_at, :end_at )
    end

end
