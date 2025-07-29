class ForecastDataController < ApplicationController
  def index
  end

  def create
    address = params[:address]
    @current_conditions = FetchAddressCurrentConditionsService.new(address).call
    
    turbo_stream
  end
end
