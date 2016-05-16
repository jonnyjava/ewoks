describe 'quote_proposals/show' do
  before(:each) do
    view.stub(:current_user) { FactoryGirl.create(:admin) }
    quote_proposal = FactoryGirl.create(:quote_proposal).decorate
    @quote_proposal = assign(:quote_proposal, quote_proposal)
  end

  it 'renders' do
    render
  end
end
