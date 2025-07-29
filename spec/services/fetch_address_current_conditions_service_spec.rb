require 'rails_helper'

RSpec.describe FetchAddressCurrentConditionsService, type: :service do
  describe "#call" do
    it "returns the current conditions for an address" do
      address = "1600 Pennsylvania Ave NW, Washington, DC 20500"

      result = with_google_maps_cassettes do
        FetchAddressCurrentConditionsService.new(address).call
      end

      expect(result).to include("temperature", "currentConditionsHistory", "weatherCondition")
    end
  end

  def with_google_maps_cassettes
    VCR.use_cassette("successfully_geocoded_address") do
      VCR.use_cassette("successfully_fetch_current_conditions") do
        yield
      end
    end
  end
end
