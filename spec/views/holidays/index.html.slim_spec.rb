require 'spec_helper'

describe "holidays/index" do
  before(:each) do
    assign(:holidays, [
      stub_model(Holiday),
      stub_model(Holiday)
    ])
  end

  it "renders a list of holidays" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
