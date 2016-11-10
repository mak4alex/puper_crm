class ValuesController < ApplicationController
  def create
    Value.save_array(params[:values])
    redirect_back(fallback_location: root_path)
  end
end
