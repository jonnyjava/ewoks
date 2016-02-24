require 'spec_helper'

describe "TyreFees" do
  describe "GET /tyre_fees" do
    login_admin
    let!(:garage) { FactoryGirl.create(:garage_with_timetable) }
    it "works! (now write some real specs)" do
      get garage_tyre_fees_path(garage)
      expect(response.status).to be(200)
    end
  end
end
