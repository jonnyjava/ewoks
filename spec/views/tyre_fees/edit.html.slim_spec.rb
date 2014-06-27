require 'spec_helper'

describe "tyre_fees/edit" do
  before(:each) do
    @tyre_fee = assign(:tyre_fee, stub_model(TyreFee))
  end

  it "renders the edit tyre_fee form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", tyre_fee_path(@tyre_fee), "post" do
    end
  end
end
