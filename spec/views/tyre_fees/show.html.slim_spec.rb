require 'spec_helper'

describe "tyre_fees/show" do
  before(:each) do
    @tyre_fee = assign(:tyre_fee, stub_model(TyreFee))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
