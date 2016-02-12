require "spec_helper"

describe API::V1::GarageRegistrationsController do
  describe "routing" do

    it "routes to #create" do
      expect(api_post('garage_registrations')).to route_to("api/v1/garage_registrations#create")
    end
  end

  describe "versioning" do
    it 'routes version' do
      assert_generates 'api/v1/garage_registrations', { controller: 'api/v1/garage_registrations', action: 'create' }
    end
  end
end
