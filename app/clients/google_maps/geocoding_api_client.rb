
class GoogleMaps::GeocodingApiClient < GoogleMaps::GoogleMapsApiClient
    def initialize(api_key: ENV["GOOGLE_MAPS_API_KEY"], host: ENV["GOOGLE_MAPS_GEOCODING_API_HOST"])
        super(api_key:, host:)
    end

    def geocode_address(address)
        @connection.get("/maps/api/geocode/json") do |req|
            req.params["address"] = address
        end
    end
end
