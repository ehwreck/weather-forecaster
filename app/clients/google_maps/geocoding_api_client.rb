
class GoogleMaps::GeocodingApiClient < GoogleMaps::GoogleMapsApiClient
    def initialize(api_key: ENV["GOOGLE_MAPS_API_KEY"], host: ENV["GOOGLE_MAPS_GEOCODING_API_HOST"])
        super(api_key:, host:)
    end

    def geocode_address(address)
        response = @connection.get("/maps/api/geocode/json") do |req|
            req.params["address"] = address
        end

        unless response.success?
            handle_error response, "Error geocoding address: #{address}. Status code: #{response.status}"
        end

        body = JSON.parse(response.body)

        if body["status"] == "REQUEST_DENIED"
            handle_error response, "Invalid API key. Error: #{body["status"]}"
        elsif body["status"] == "ZERO_RESULTS"
            handle_error response, "Unable to geocode #{address}. Error: #{body["status"]}"
        elsif body["results"].empty?
            handle_error response, "Error geocoding address: #{address}. Error: #{body["status"]}"
        end

        body
    end
end
