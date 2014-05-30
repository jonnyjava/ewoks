require "spec_helper"

describe GaragesController do
  describe "routing" do

    it "routes to #index" do
      get("/garages").should route_to("garages#index")
    end

    it "routes to #new" do
      get("/garages/new").should route_to("garages#new")
    end

    it "routes to #show" do
      get("/garages/1").should route_to("garages#show", :id => "1")
    end

    it "routes to #edit" do
      get("/garages/1/edit").should route_to("garages#edit", :id => "1")
    end

    it "routes to #create" do
      post("/garages").should route_to("garages#create")
    end

    it "routes to #update" do
      put("/garages/1").should route_to("garages#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/garages/1").should route_to("garages#destroy", :id => "1")
    end

  end
end
