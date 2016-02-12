require "spec_helper"

describe API::V1::GaragesController do
  describe "routing" do

    it "routes to #index" do
      expect(api_get('garages')).to route_to("api/v1/garages#index")
    end
  end

  describe "versioning" do
      it 'routes version' do
      assert_generates 'api/v1/garages', { controller: 'api/v1/garages', action: 'index' }
    end
  end
end
