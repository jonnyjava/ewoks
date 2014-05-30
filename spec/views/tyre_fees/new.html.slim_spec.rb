require 'spec_helper'

describe "tyre_fees/new" do
  before(:each) do
    assign(:tyre_fee, stub_model(TyreFee).as_new_record)
  end

  it "renders new tyre_fee form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", tyre_fees_path, "post" do
    end
  end
end
