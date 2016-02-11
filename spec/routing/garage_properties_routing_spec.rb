require "spec_helper"

describe GaragePropertiesController do
  describe "routing" do

    it "routes to #index" do
      expect(get("/garages/1/properties")).to route_to("garage_properties#index", garage_id: '1')
    end

    it "routes to #new" do
      expect(get("/garages/1/properties/new")).to route_to("garage_properties#new", garage_id: '1')
    end

    it "routes to #show" do
      expect(get("/garages/1/properties/1")).to route_to("garage_properties#show", garage_id: '1', :id => "1")
    end

    it "routes to #edit" do
      expect(get("/garages/1/properties/1/edit")).to route_to("garage_properties#edit", garage_id: '1', :id => "1")
    end

    it "routes to #create" do
      expect(post("/garages/1/properties")).to route_to("garage_properties#create", garage_id: '1')
    end

    it "routes to #update" do
      expect(put("/garages/1/properties/1")).to route_to("garage_properties#update", garage_id: '1', :id => "1")
    end

    it "routes to #destroy" do
      expect(delete("/garages/1/properties/1")).to route_to("garage_properties#destroy", garage_id: '1', :id => "1")
    end

  end
end
