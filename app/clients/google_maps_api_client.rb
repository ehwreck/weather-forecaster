class GoogleMapsApiClient
    def initialize(api_key: ENV["GOOGLE_MAPS_API_KEY"], host: ENV["GOOGLE_MAPS_API_HOST"])
        @api_key = api_key
        @connection = build_connection(api_key, host)
    end

    def geocode_address(address)
        @connection.get("/maps/api/geocode/json") do |req|
            req.params["address"] = address
        end
    end

    private

    def build_connection(api_key, host)
        Faraday.new(
            url: host,
            params: { "key" => api_key }
        )
    end
end
