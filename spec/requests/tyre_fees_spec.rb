require 'spec_helper'

describe "TyreFees" do
  describe "GET /tyre_fees" do
    login_user
    let!(:garage) { FactoryGirl.create(:garage) }
    it "works! (now write some real specs)" do
      get garage_tyre_fees_path(garage)
      response.status.should be(200)
    end
  end
end
