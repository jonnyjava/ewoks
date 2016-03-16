require "spec_helper"

RSpec.describe GarageRecruitablesController, type: :routing do
  describe "routing" do
    it { expect(get: "/garage_recruitables").to route_to("garage_recruitables#index") }
    it { expect(get: "/garage_recruitables/new").to_not route_to("garage_recruitables#new") }
    it { expect(get: "/garage_recruitables/1").to route_to("garage_recruitables#show", id: "1") }
    it { expect(get: "/garage_recruitables/1/edit").to route_to("garage_recruitables#edit", id: "1") }
    it { expect(post: "/garage_recruitables").to route_to("garage_recruitables#create") }
    it { expect(put: "/garage_recruitables/1").to route_to("garage_recruitables#update", id: "1") }
    it { expect(patch: "/garage_recruitables/1").to route_to("garage_recruitables#update", id: "1") }
    it { expect(delete: "/garage_recruitables/1").to route_to("garage_recruitables#destroy", id: "1") }
  end
end
