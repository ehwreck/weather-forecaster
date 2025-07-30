class ForecastDataController < ApplicationController
  def index
  end

  def create
    address = params[:address]
    zip = address.split(" ")[-1] # this is pretty flaky, ideally would like to implement an address checker and extract the zipcode if the address is valid

    @current_conditions = Rails.cache.read(zip)

    if @current_conditions
      @cached = true
    else
      begin
        @current_conditions = FetchAddressCurrentConditionsService.new(address).call
        Rails.cache.write(zip, @current_conditions, expires_in: 30.minutes)
      rescue StandardError => e
        @alerts = [ { type: "error", message: e.message } ]
        invalid_address_response
      end
    end
  end

  private

  def invalid_address_response
    respond_to do |format|
      format.turbo_stream { render :invalid_address, status: :unprocessable_entity }
      format.html { render :index }
    end
  end
end
