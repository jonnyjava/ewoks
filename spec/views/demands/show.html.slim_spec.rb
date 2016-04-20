require 'spec_helper'

describe 'demands/show', type: :view do
  before(:each) do
    view.stub(:current_user) { FactoryGirl.create(:admin) }
    @demand = assign(:demand, FactoryGirl.create(:demand).decorate)
  end

  it 'renders' do
    render
  end
end
