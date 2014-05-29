require "spec_helper"

describe TyreFeesController do
  describe "routing" do

    it "routes to #index" do
      get("/tyre_fees").should route_to("tyre_fees#index")
    end

    it "routes to #new" do
      get("/tyre_fees/new").should route_to("tyre_fees#new")
    end

    it "routes to #show" do
      get("/tyre_fees/1").should route_to("tyre_fees#show", :id => "1")
    end

    it "routes to #edit" do
      get("/tyre_fees/1/edit").should route_to("tyre_fees#edit", :id => "1")
    end

    it "routes to #create" do
      post("/tyre_fees").should route_to("tyre_fees#create")
    end

    it "routes to #update" do
      put("/tyre_fees/1").should route_to("tyre_fees#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/tyre_fees/1").should route_to("tyre_fees#destroy", :id => "1")
    end

  end
end
