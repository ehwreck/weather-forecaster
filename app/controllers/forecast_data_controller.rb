class ForecastDataController < ApplicationController
  def index
  end

  def create
    address = params[:address]
    zip = address.split(" ")[-1] # this is pretty flaky, ideally would like to implement an address checker and extract the zipcode if the address is valid
    @cached = false

    @current_conditions = Rails.cache.read(zip)

    if @current_conditions
      @cached = true
    else
      @current_conditions = FetchAddressCurrentConditionsService.new(address).call
      Rails.cache.write(zip, @current_conditions, expires_in: 30.minutes)
    end

    turbo_stream
  end
end
