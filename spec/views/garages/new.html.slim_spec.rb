require 'spec_helper'

describe "garages/new" do
  before(:each) do
    assign(:garage, stub_model(Garage).as_new_record)
  end

  it "renders new garage form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", garages_path, "post" do
    end
  end
end
