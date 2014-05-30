require 'spec_helper'

describe "Holidays" do
  describe "GET /holidays" do
    login_user
    it "works! (now write some real specs)" do
      get holidays_path
      response.status.should be(200)
    end
  end
end
