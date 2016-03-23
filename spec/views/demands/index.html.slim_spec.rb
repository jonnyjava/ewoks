require 'spec_helper'

describe "demands/index", type: :view do
  before(:each) do
    FactoryGirl.create_list(:demand, 3)
    assign(:demands, Demand.all.page(params[:page]))
  end

  it "renders a list of demands" do
    render
  end
end
