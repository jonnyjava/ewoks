require "spec_helper"

describe HolidaysController do
  describe "routing" do
    it { expect(get: "/garages/1/holidays").to route_to("holidays#index", garage_id: '1') }
    it { expect(get: "/garages/1/holidays/new").to route_to("holidays#new", garage_id: '1') }
    it { expect(get: "/garages/1/holidays/1").to route_to("holidays#show", garage_id: '1', id: '1') }
    it { expect(get: "/garages/1/holidays/1/edit").to route_to("holidays#edit", garage_id: '1', id: '1') }
    it { expect(post: "/garages/1/holidays").to route_to("holidays#create", garage_id: '1') }
    it { expect(put: "/garages/1/holidays/1").to route_to("holidays#update", garage_id: '1', id: '1') }
    it { expect(delete: "/garages/1/holidays/1").to route_to("holidays#destroy", garage_id: '1', id: '1') }
  end
end
