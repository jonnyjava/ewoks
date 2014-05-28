require 'spec_helper'

describe "garages/show" do
  before(:each) do
    @garage = assign(:garage, stub_model(Garage))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
