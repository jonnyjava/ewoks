require 'spec_helper'

describe "quote_proposals/show"do
  before(:each) do
    view.stub(:current_user) { FactoryGirl.create(:admin) }
    @quote_proposal = assign(:quote_proposal, FactoryGirl.create(:quote_proposal).decorate)
  end

  it "renders" do
    render
  end
end
