require 'spec_helper'

RSpec.describe 'quote_proposals/new', type: :view do
  before(:each) do
    assign(:quote_proposal, FactoryGirl.create(:quote_proposal))
  end

  it 'renders new quote_proposal form' do
    render
  end
end
