describe 'demands/show', type: :view do
  before(:each) do
    user = assign(:user, FactoryGirl.create(:owner))
    sign_in user
    @demand = assign(:demand, FactoryGirl.create(:demand).decorate)
    garage = FactoryGirl.create(:garage, user: user)
    FactoryGirl.create(:demands_garage, demand: @demand, garage: garage)
  end

  it 'renders' do
    render
  end
end
