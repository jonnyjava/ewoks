require "spec_helper"

describe API::V1::ServicesController do
  describe "routing" do
    it { expect(api_get('services')).to route_to("api/v1/services#index") }
  end

  describe "versioning" do
      it 'routes version' do
      assert_generates 'api/v1/services', { controller: 'api/v1/services', action: 'index' }
    end
  end
end
