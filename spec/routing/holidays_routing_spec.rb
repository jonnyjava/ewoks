require "spec_helper"

describe HolidaysController do
  describe "routing" do

    it "routes to #index" do
      get("/garages/1/holidays").should route_to("holidays#index", garage_id: '1')
    end

    it "routes to #new" do
      get("/garages/1/holidays/new").should route_to("holidays#new", garage_id: '1')
    end

    it "routes to #show" do
      get("/garages/1/holidays/1").should route_to("holidays#show", garage_id: '1', id: '1')
    end

    it "routes to #edit" do
      get("/garages/1/holidays/1/edit").should route_to("holidays#edit", garage_id: '1', id: '1')
    end

    it "routes to #create" do
      post("/garages/1/holidays").should route_to("holidays#create", garage_id: '1')
    end

    it "routes to #update" do
      put("/garages/1/holidays/1").should route_to("holidays#update", garage_id: '1', id: '1')
    end

    it "routes to #destroy" do
      delete("/garages/1/holidays/1").should route_to("holidays#destroy", garage_id: '1', id: '1')
    end

  end
end
