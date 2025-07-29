require "rails_helper"

module GoogleMaps
  RSpec.describe GeocodingApiClient, type: :client do
    describe "#geocode_address" do
      context "when a valid address is given" do
        it 'returns a JSON response that contains status and results', vcr: 'successfully_geocoded_address' do
          address = "1600 Pennsylvania Ave NW, Washington, DC 20500"
          response = GeocodingApiClient.new.geocode_address(address)

          expect(response["results"]).to be_an(Array)
          expect(response["results"]).to_not be_empty
          expect(response["results"][0]["geometry"]["location"]).to include("lat", "lng")
        end
      end

      context "when a invalid address is given" do
        it 'returns a JSON response that contains status and no results', vcr: 'address_not_found' do
          address = "some really fake address"

          expect { GeocodingApiClient.new.geocode_address(address) }.to raise_error(StandardError, /Unable to geocode/)
        end
      end

      context "when an invalid api key is given" do
        it 'returns a JSON response that contains an invalid API key message', vcr: 'invalid_api_key' do
          address = "1600 Pennsylvania Ave NW, Washington, DC 20500"

          expect { GeocodingApiClient.new(api_key: 'bad-api-key').geocode_address(address) }.to raise_error(StandardError, /Invalid API key/)
        end
      end
    end
  end
end
