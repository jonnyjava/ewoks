require "spec_helper"

describe TyreFeesController do
  describe "routing" do
    it { expect(get: "/garages/1/tyre_fees").to route_to("tyre_fees#index", garage_id: "1") }
    it { expect(get: "/garages/1/tyre_fees/new").to route_to("tyre_fees#new", garage_id: "1") }
    it { expect(get: "/garages/1/tyre_fees/1").to route_to("tyre_fees#show", garage_id: "1" , id: "1") }
    it { expect(get: "/garages/1/tyre_fees/1/edit").to route_to("tyre_fees#edit", garage_id: "1", id: "1") }
    it { expect(post: "/garages/1/tyre_fees").to route_to("tyre_fees#create", garage_id: "1") }
    it { expect(put: "/garages/1/tyre_fees/1").to route_to("tyre_fees#update", garage_id: "1", id: "1") }
    it { expect(delete: "/garages/1/tyre_fees/1").to route_to("tyre_fees#destroy", garage_id: "1", id: "1") }
  end
end
