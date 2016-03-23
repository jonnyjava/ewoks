require "spec_helper"

describe API::V1::GarageRegistrationsController do
  describe "routing" do
    it { expect(post('/api/v1/demands')).to route_to("api/v1/demands#create") }
  end

  describe "versioning" do
    it 'routes version' do
      assert_generates 'api/v1/demands', { controller: 'api/v1/demands', action: 'create' }
    end
  end
end
