require 'spec_helper'

describe "service_categories/index" do
  before(:each) do
    assign(:service_categories, [FactoryGirl.create(:service_category)])
  end

  it "renders a list of service_categories" do
    render
  end
end
