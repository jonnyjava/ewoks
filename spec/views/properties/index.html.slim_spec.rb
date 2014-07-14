require 'spec_helper'

describe "properties/index" do
  before(:each) do
    assign(:properties, Kaminari.paginate_array([
      stub_model(Property).decorate,
      stub_model(Property).decorate
    ]).page)
  end

  it "renders a list of properties" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
