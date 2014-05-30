require 'spec_helper'

describe "holidays/new" do
  before(:each) do
    assign(:holiday, stub_model(Holiday).as_new_record)
  end

  it "renders new holiday form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", holidays_path, "post" do
    end
  end
end
