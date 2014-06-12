require 'spec_helper'

describe "Garages" do
  describe "GET /garages" do
    login_user
    it "works! (now write some real specs)" do
      get garages_path
      response.status.should be(200)
    end
  end
end
