require 'spec_helper'

describe "demands/show", type: :view do
  before(:each) do
    @demand = assign(:demand, FactoryGirl.create(:demand).decorate)
  end

  it "renders" do
    render
  end
end