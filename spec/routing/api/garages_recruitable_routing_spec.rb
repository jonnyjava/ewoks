require "spec_helper"

describe API::V1::GarageRecruitablesController do
  describe "routing" do
    it { expect(api_get('garage_recruitables/1')).to route_to("api/v1/garage_recruitables#show", token: '1') }
    it { expect(patch('api/v1/garage_recruitables/1')).to route_to("api/v1/garage_recruitables#update", token: '1') }
  end

  describe "versioning" do
    it 'routes version' do
      assert_generates 'api/v1/garage_recruitables/1', { controller: 'api/v1/garage_recruitables', action: 'show', token: '1' }
    end
  end
end
