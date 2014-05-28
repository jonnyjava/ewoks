require 'spec_helper'

describe "TyreFees" do
  describe "GET /tyre_fees" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get tyre_fees_path
      response.status.should be(200)
    end
  end
end
