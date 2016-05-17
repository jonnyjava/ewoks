describe 'services/index' do
  before(:each) do
    admin = assign(:current_user, FactoryGirl.create(:admin))
    sign_in admin
    assign(:services, [FactoryGirl.create(:service)])
  end

  it 'renders a list of services' do
    render
  end
end
