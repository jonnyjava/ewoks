require "spec_helper"

describe TimetablesController do
  describe "routing" do
    it { expect(get: "/garages/1/timetables").to route_to("timetables#index", garage_id: "1") }
    it { expect(get: "/garages/1/timetables/new").to route_to("timetables#new", garage_id: "1") }
    it { expect(get: "/garages/1/timetables/1").to route_to("timetables#show", garage_id: "1" , id: "1") }
    it { expect(get: "/garages/1/timetables/1/edit").to route_to("timetables#edit", garage_id: "1", id: "1") }
    it { expect(post: "/garages/1/timetables").to route_to("timetables#create", garage_id: "1") }
    it { expect(put: "/garages/1/timetables/1").to route_to("timetables#update", garage_id: "1", id: "1") }
    it { expect(patch: "/garages/1/timetables/1").to route_to("timetables#update", garage_id: "1", id: "1") }
    it { expect(delete: "/garages/1/timetables/1").to route_to("timetables#destroy", garage_id: "1", id: "1") }
  end
end
