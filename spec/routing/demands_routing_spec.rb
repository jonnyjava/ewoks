require "spec_helper"

describe DemandsController do
  describe "routing" do
    it { expect(get: "/demands").to route_to("demands#index") }
    it { expect(get: "/demands/new").to_not route_to("demands#new") }
    it { expect(get: "/demands/1").to route_to("demands#show", id: "1") }
    it { expect(get: "/demands/1/edit").to route_to("demands#edit", id: "1") }
    it { expect(post: "/demands").to_not route_to("demands#create") }
    it { expect(put: "/demands/1").to route_to("demands#update", id: "1") }
    it { expect(patch: "/demands/1").to route_to("demands#update", id: "1") }
    it { expect(delete: "/demands/1").to route_to("demands#destroy", id: "1") }
  end
end
