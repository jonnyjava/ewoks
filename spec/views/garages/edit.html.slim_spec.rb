require 'spec_helper'

describe "garages/edit" do
  before(:each) do
    @garage = assign(:garage, stub_model(Garage))
  end

  it "renders the edit garage form" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", garage_path(@garage), "post" do
    end
  end
end
