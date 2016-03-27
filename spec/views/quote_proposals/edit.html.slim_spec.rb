require 'spec_helper'

RSpec.describe "quote_proposals/edit", type: :view do
  before(:each) do
    @quote_proposal = assign(:quote_proposal, FactoryGirl.create(:quote_proposal).decorate)
  end

  it "renders the edit quote_proposal form" do
    render
  end
end
