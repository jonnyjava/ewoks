require "spec_helper"

describe GaragePropertiesController do
  describe "routing" do

    it "routes to #index" do
      get("/garages/1/properties").should route_to("garage_properties#index", garage_id: '1')
    end

    it "routes to #new" do
      get("/garages/1/properties/new").should route_to("garage_properties#new", garage_id: '1')
    end

    it "routes to #show" do
      get("/garages/1/properties/1").should route_to("garage_properties#show", garage_id: '1', :id => "1")
    end

    it "routes to #edit" do
      get("/garages/1/properties/1/edit").should route_to("garage_properties#edit", garage_id: '1', :id => "1")
    end

    it "routes to #create" do
      post("/garages/1/properties").should route_to("garage_properties#create", garage_id: '1')
    end

    it "routes to #update" do
      put("/garages/1/properties/1").should route_to("garage_properties#update", garage_id: '1', :id => "1")
    end

    it "routes to #destroy" do
      delete("/garages/1/properties/1").should route_to("garage_properties#destroy", garage_id: '1', :id => "1")
    end

  end
end
