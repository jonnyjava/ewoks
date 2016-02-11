require "spec_helper"

describe TyreFeesController do
  describe "routing" do

    it "routes to #index" do
      expect(get("/garages/1/tyre_fees")).to route_to("tyre_fees#index", garage_id: "1")
    end

    it "routes to #new" do
      expect(get("/garages/1/tyre_fees/new")).to route_to("tyre_fees#new", garage_id: "1")
    end

    it "routes to #show" do
      expect(get("/garages/1/tyre_fees/1")).to route_to("tyre_fees#show", garage_id: "1" , id: "1")
    end

    it "routes to #edit" do
      expect(get("/garages/1/tyre_fees/1/edit")).to route_to("tyre_fees#edit", garage_id: "1", id: "1")
    end

    it "routes to #create" do
      expect(post("/garages/1/tyre_fees")).to route_to("tyre_fees#create", garage_id: "1")
    end

    it "routes to #update" do
      expect(put("/garages/1/tyre_fees/1")).to route_to("tyre_fees#update", garage_id: "1", id: "1")
    end

    it "routes to #destroy" do
      expect(delete("/garages/1/tyre_fees/1")).to route_to("tyre_fees#destroy", garage_id: "1", id: "1")
    end

  end
end
