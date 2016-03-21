require 'spec_helper'

describe "TyreFees" do
  login_admin
  let!(:garage) { FactoryGirl.create(:garage) }
  let!(:tyre_fee) { FactoryGirl.create(:tyre_fee, garage: garage) }
  describe "index" do
    it "should render the tyre_fee index" do
      get garage_tyre_fees_path(garage)
      expect(response.status).to be(200)
    end
  end

  describe "get" do
    it "should render the 404 page" do
      get garage_tyre_fee_path(garage, tyre_fee)
      expect(response.status).to be(404)
    end
  end

  describe "edit" do
    it "should render the tyre_fee sheet" do
      get edit_garage_tyre_fee_path(garage, tyre_fee)
      expect(response.status).to be(200)
    end
  end
end
