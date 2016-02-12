require 'spec_helper'

describe "Garages" do
  describe "GET /garages" do
    login_user

    it "should return status 200 rendering garage index" do
      get garages_path
      expect(response.status).to be(200)
    end

    it "should return status 200 calling toggle status" do
      garage = FactoryGirl.create(:garage)
      expect(response.status).to be(200)
    end
  end
end
