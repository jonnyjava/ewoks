require 'spec_helper'

describe "GarageProperties" do
  describe "GET /garages/:garage_id/garage_properties" do
    login_user
    let!(:garage) { FactoryGirl.create(:garage) }
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get garage_properties_path(garage)
      response.status.should be(200)
    end
  end
end
