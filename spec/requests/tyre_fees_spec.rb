require 'spec_helper'

describe "TyreFees" do
  describe "GET /tyre_fees" do
    login_user
    it "works! (now write some real specs)" do
      get tyre_fees_path
      response.status.should be(200)
    end
  end
end
