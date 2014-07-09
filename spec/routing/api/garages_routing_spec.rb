require "spec_helper"

describe API::GaragesController do
  describe "routing" do

    it "routes to #index" do
      get("http://api.localhost.dev/garages").should route_to("api/garages#index", subdomain: 'api')
    end

  end
end
