require 'spec_helper'

describe 'services/index' do
  before(:each) do
    view.stub(:current_user) { FactoryGirl.create(:admin) }
    assign(:services, [FactoryGirl.create(:service)])
  end

  it 'renders a list of services' do
    render
  end
end
