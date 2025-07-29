class FetchAddressCurrentConditionsService
  def initialize(address)
    @address = address
  end

  def call
    geocoded_data = GoogleMaps::GeocodingApiClient.new.geocode_address(@address)
    coordinates = geocoded_data["results"][0]["geometry"]["location"]
    current_conditions = GoogleMaps::WeatherApiClient.new.fetch_current_conditions(coordinates["lat"], coordinates["lng"])
  end
end
