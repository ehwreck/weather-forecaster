require "rails_helper"

module GoogleMaps
  RSpec.describe GoogleMapsApiClient, type: :client do
    context "when no arguments are given" do
      it "returns a Faraday connection object without errors" do
        client = GoogleMapsApiClient.new
        connection = client.instance_variable_get(:@connection)

        expect { client }.to_not raise_error
        expect(connection.class).to eq(Faraday::Connection)
        expect(connection.url_prefix.to_s).to eq("/")
      end
    end

    context "when an API key and host are given" do
      it "builds a Faraday connection with the correct base URL and includes the API key in the default params" do
        api_key = 'test_api_key'
        host = 'https://example.com'

        client = GoogleMapsApiClient.new(api_key:, host:)
        connection = client.instance_variable_get(:@connection)

        expect(connection.url_prefix.to_s).to eq("#{host}/")
        expect(connection.params["key"]).to eq("test_api_key")
      end
    end
  end
end
