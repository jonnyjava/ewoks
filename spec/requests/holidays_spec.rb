require 'spec_helper'

describe "Holidays" do
  describe "GET /garages/:garage_id/holidays" do
    login_user
    let!(:garage) { FactoryGirl.create(:garage) }
    it "works! (now write some real specs)" do
      get garage_holidays_path(garage)
      response.status.should be(200)
    end
  end
end
