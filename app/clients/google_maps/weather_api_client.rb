class GoogleMaps::WeatherApiClient < GoogleMaps::GoogleMapsApiClient
    def initialize(api_key: ENV["GOOGLE_MAPS_API_KEY"], host: ENV["GOOGLE_MAPS_WEATHER_API_HOST"])
        super(api_key:, host:)
    end

    def fetch_current_conditions(latitude, longitude)
        response = @connection.get("/v1/currentConditions:lookup") do |req|
            req.params["location.latitude"] = latitude
            req.params["location.longitude"] = longitude
            req.params["unitsSystem"] = "IMPERIAL"
        end

        unless response.success?
            handle_error response, "Error fetching current conditions for lat: #{latitude} and long: #{longitude}. Status code: #{response.status}"
        end

        JSON.parse(response.body)
    end
end
