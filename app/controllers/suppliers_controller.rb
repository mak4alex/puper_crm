class SuppliersController < ApplicationController
  def index
    @suppliers = Supplier.includes(:contact, :manager).all
  end

  def show
  end
end
