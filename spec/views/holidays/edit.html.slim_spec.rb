require 'spec_helper'

describe "holidays/edit" do
  before(:each) do
    @holiday = assign(:holiday, stub_model(Holiday))
  end

  it "renders the edit holiday form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", holiday_path(@holiday), "post" do
    end
  end
end
