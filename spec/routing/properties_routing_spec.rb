require "spec_helper"

describe PropertiesController do
  describe "routing" do
    it { expect(get("/properties")).to route_to("properties#index") }
    it { expect(get("/properties/new")).to route_to("properties#new") }
    it { expect(get("/properties/1")).to route_to("properties#show", :id => "1") }
    it { expect(get("/properties/1/edit")).to route_to("properties#edit", :id => "1") }
    it { expect(post("/properties")).to route_to("properties#create") }
    it { expect(put("/properties/1")).to route_to("properties#update", :id => "1") }
    it { expect(delete("/properties/1")).to route_to("properties#destroy", :id => "1") }
  end
end
