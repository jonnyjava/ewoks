require "spec_helper"

describe API::GaragesController do
  describe "routing" do

    it "routes to #index" do
      api_get('garages').should route_to("api/garages#index", subdomain: 'api')
    end

  end
end
