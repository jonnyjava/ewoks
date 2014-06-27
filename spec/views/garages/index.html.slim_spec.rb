require 'spec_helper'

describe "garages/index" do
  before(:each) do
    assign(:garages, Kaminari.paginate_array([
      stub_model(Garage),
      stub_model(Garage)
    ]).page)
  end

  it "renders a list of garages" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
