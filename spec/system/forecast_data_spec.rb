require 'rails_helper'

RSpec.describe 'Forecast Data', type: :system, js: true do
  before { driven_by(:rack_test) }

  it 'allows me to get current conditions for an address' do
    visit '/'

    fill_in "Enter address", with: "1600 Pennsylvania Ave NW, Washington, DC 20500"

    with_google_maps_cassettes { click_button }

    expect(page).to have_text("Low:")
    expect(page).to have_text("High:")
  end

  it 'displays an error message when request fails' do
    visit '/'

    service_double = instance_double(FetchAddressCurrentConditionsService)
    allow(FetchAddressCurrentConditionsService).to receive(:new).and_return(service_double)
    allow(service_double).to receive(:call).and_raise(StandardError, "Unable to geocode some fake address. Error: ZERO_RESULTS")

    fill_in "Enter address", with: "some fake address"

    click_button

    expect(page).to have_text("Unable to geocode some fake address. Error: ZERO_RESULTS")
  end

  def with_google_maps_cassettes
    VCR.use_cassette("successfully_geocoded_address") do
      VCR.use_cassette("successfully_fetch_current_conditions") do
        yield
      end
    end
  end
end
