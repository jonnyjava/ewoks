require "spec_helper"

describe GaragePropertiesController do
  describe "routing" do
    it { expect(get("/garages/1/properties")).to route_to("garage_properties#index", garage_id: '1') }
    it { expect(get("/garages/1/properties/new")).to route_to("garage_properties#new", garage_id: '1') }
    it { expect(get("/garages/1/properties/1")).to route_to("garage_properties#show", garage_id: '1', :id => "1") }
    it { expect(get("/garages/1/properties/1/edit")).to route_to("garage_properties#edit", garage_id: '1', :id => "1") }
    it { expect(post("/garages/1/properties")).to route_to("garage_properties#create", garage_id: '1') }
    it { expect(put("/garages/1/properties/1")).to route_to("garage_properties#update", garage_id: '1', :id => "1") }
    it { expect(delete("/garages/1/properties/1")).to route_to("garage_properties#destroy", garage_id: '1', :id => "1") }
  end
end
