require "spec_helper"

describe API::V1::QuoteProposalsController do
  describe "routing" do
    it { expect(api_get('quote_proposals/1')).to route_to("api/v1/quote_proposals#show", token: '1') }
    it { expect(patch('api/v1/quote_proposals/1')).to route_to("api/v1/quote_proposals#update", token: '1') }
  end

  describe "versioning" do
    it 'routes version' do
      assert_generates 'api/v1/quote_proposals/1', { controller: 'api/v1/quote_proposals', action: 'show', token: '1' }
    end
  end
end
