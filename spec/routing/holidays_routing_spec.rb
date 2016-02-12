require "spec_helper"

describe HolidaysController do
  describe "routing" do

    it "routes to #index" do
      expect(get("/garages/1/holidays")).to route_to("holidays#index", garage_id: '1')
    end

    it "routes to #new" do
      expect(get("/garages/1/holidays/new")).to route_to("holidays#new", garage_id: '1')
    end

    it "routes to #show" do
      expect(get("/garages/1/holidays/1")).to route_to("holidays#show", garage_id: '1', id: '1')
    end

    it "routes to #edit" do
      expect(get("/garages/1/holidays/1/edit")).to route_to("holidays#edit", garage_id: '1', id: '1')
    end

    it "routes to #create" do
      expect(post("/garages/1/holidays")).to route_to("holidays#create", garage_id: '1')
    end

    it "routes to #update" do
      expect(put("/garages/1/holidays/1")).to route_to("holidays#update", garage_id: '1', id: '1')
    end

    it "routes to #destroy" do
      expect(delete("/garages/1/holidays/1")).to route_to("holidays#destroy", garage_id: '1', id: '1')
    end

  end
end
