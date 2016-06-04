describe "demands/edit" do
  before(:each) do
    assign(:current_user, FactoryGirl.create(:admin))
    @demand = assign(:demand, FactoryGirl.create(:demand))
  end

  it "renders the edit demand form" do
    render
  end
end
