require "spec_helper"

describe TyreFeesController do
  describe "routing" do

    it "routes to #index" do
      get("/garages/1/tyre_fees").should route_to("tyre_fees#index", garage_id: "1")
    end

    it "routes to #new" do
      get("/garages/1/tyre_fees/new").should route_to("tyre_fees#new", garage_id: "1")
    end

    it "routes to #show" do
      get("/garages/1/tyre_fees/1").should route_to("tyre_fees#show", garage_id: "1" , id: "1")
    end

    it "routes to #edit" do
      get("/garages/1/tyre_fees/1/edit").should route_to("tyre_fees#edit", garage_id: "1", id: "1")
    end

    it "routes to #create" do
      post("/garages/1/tyre_fees").should route_to("tyre_fees#create", garage_id: "1")
    end

    it "routes to #update" do
      put("/garages/1/tyre_fees/1").should route_to("tyre_fees#update", garage_id: "1", id: "1")
    end

    it "routes to #destroy" do
      delete("/garages/1/tyre_fees/1").should route_to("tyre_fees#destroy", garage_id: "1", id: "1")
    end

  end
end
