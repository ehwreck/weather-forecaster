module GoogleMaps
  class GoogleMapsApiClient
    def initialize(api_key: ENV["GOOGLE_MAPS_API_KEY"], host: "")
      @api_key = api_key
      @connection = build_connection(api_key, host)
    end

    private

    def build_connection(api_key, host)
      Faraday.new(
        url: host,
        params: { "key" => api_key }
      )
    end
  end
end
