require "rails_helper"

module GoogleMaps
  RSpec.describe WeatherApiClient, type: :client do
    describe "#fetch_current_conditions" do
      it "returns a good response", vcr: 'successfully_fetch_current_conditions' do
        latitude = 38.89771400000001
        longitude = -77.0365461

        response = WeatherApiClient.new.fetch_current_conditions(latitude, longitude)

        expect(response.status).to eq(200)

        json = JSON.parse(response.body)
        expect(json).to include("currentTime", "temperature", "feelsLikeTemperature")
      end
    end
  end
end
