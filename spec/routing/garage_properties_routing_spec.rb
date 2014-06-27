require "spec_helper"

describe GaragePropertiesController do
  describe "routing" do

    it "routes to #index" do
      get("/garage_properties").should route_to("garage_properties#index")
    end

    it "routes to #new" do
      get("/garage_properties/new").should route_to("garage_properties#new")
    end

    it "routes to #show" do
      get("/garage_properties/1").should route_to("garage_properties#show", :id => "1")
    end

    it "routes to #edit" do
      get("/garage_properties/1/edit").should route_to("garage_properties#edit", :id => "1")
    end

    it "routes to #create" do
      post("/garage_properties").should route_to("garage_properties#create")
    end

    it "routes to #update" do
      put("/garage_properties/1").should route_to("garage_properties#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/garage_properties/1").should route_to("garage_properties#destroy", :id => "1")
    end

  end
end
