require "spec_helper"

describe QuoteProposalsController do
  describe "routing" do
    it { expect(get: "/quote_proposals").to route_to("quote_proposals#index") }
    it { expect(get: "/quote_proposals/new/1").to route_to("quote_proposals#new", demands_garage_id: "1") }
    it { expect(get: "/quote_proposals/1").to route_to("quote_proposals#show", id: "1") }
    it { expect(get: "/quote_proposals/1/edit").to route_to("quote_proposals#edit", id: "1") }
    it { expect(post: "/quote_proposals").to route_to("quote_proposals#create") }
    it { expect(put: "/quote_proposals/1").to route_to("quote_proposals#update", id: "1") }
    it { expect(patch: "/quote_proposals/1").to route_to("quote_proposals#update", id: "1") }
    it { expect(delete: "/quote_proposals/1").to route_to("quote_proposals#destroy", id: "1") }
  end
end
