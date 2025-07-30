require "rails_helper"

RSpec.describe ForecastDataController, type: :controller do
  describe "GET root and /forecast_data" do
    it 'returns 200 and renders the forecast_data/index.html.erb' do
      get :index, params: {}, format: :html

      expect(response).to have_http_status(200)
      expect(response.content_type).to eq("text/html; charset=utf-8")
    end
  end

  describe "POST /forecast_data" do
    it 'returns 200 if request successfull and responds with turbo_stream create' do
      post :create, params: { address: "1600 Pennsylvania Ave NW, Washington, DC 20500" }, format: :turbo_stream

      expect(response).to have_http_status(200)
      expect(response.content_type).to eq("text/vnd.turbo-stream.html; charset=utf-8")
    end

    it 'returns 400 if the request is not successfull and responds with turbo_stream invalid_address' do
      post :create, params: { address: "some fake address" }, format: :turbo_stream

      expect(response).to have_http_status(422)
      expect(response.content_type).to eq("text/vnd.turbo-stream.html; charset=utf-8")
    end
  end
end

