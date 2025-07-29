require "rails_helper"

module GoogleMaps
  RSpec.describe WeatherApiClient, type: :client do
    describe "#fetch_current_conditions" do
      it "returns a hash of current conditions when successful", vcr: 'successfully_fetch_current_conditions' do
        latitude = 38.89771400000001
        longitude = -77.0365461

        response = WeatherApiClient.new.fetch_current_conditions(latitude, longitude)

        expect(response).to include("currentTime", "temperature", "feelsLikeTemperature")
      end

      it "raises an error when not successfull", vcr: "unsuccessful_fetch_current_conditions" do
        latitude = "A"
        longitude = "B"

        expect {
          WeatherApiClient.new.fetch_current_conditions(latitude, longitude)
        }.to raise_error(StandardError, /Error fetching current conditions for/)
      end
    end
  end
end
