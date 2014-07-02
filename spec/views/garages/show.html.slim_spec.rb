require 'spec_helper'

describe "garages/show" do
  it "renders garage show" do
    @garage = FactoryGirl.create(:garage)
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
