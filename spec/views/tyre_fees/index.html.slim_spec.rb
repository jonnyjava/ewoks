require 'spec_helper'

describe "tyre_fees/index" do
  before(:each) do
    assign(:tyre_fees, [
      stub_model(TyreFee),
      stub_model(TyreFee)
    ])
  end

  it "renders a list of tyre_fees" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
