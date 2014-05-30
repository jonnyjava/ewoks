require "spec_helper"

describe HolidaysController do
  describe "routing" do

    it "routes to #index" do
      get("/holidays").should route_to("holidays#index")
    end

    it "routes to #new" do
      get("/holidays/new").should route_to("holidays#new")
    end

    it "routes to #show" do
      get("/holidays/1").should route_to("holidays#show", :id => "1")
    end

    it "routes to #edit" do
      get("/holidays/1/edit").should route_to("holidays#edit", :id => "1")
    end

    it "routes to #create" do
      post("/holidays").should route_to("holidays#create")
    end

    it "routes to #update" do
      put("/holidays/1").should route_to("holidays#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/holidays/1").should route_to("holidays#destroy", :id => "1")
    end

  end
end
