require 'spec_helper'

describe "garages/index" do
  before(:each) do
    assign(:garages, [
      stub_model(Garage),
      stub_model(Garage)
    ])
  end

  it "renders a list of garages" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
