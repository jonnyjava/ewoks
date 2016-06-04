describe 'quote_proposals/index' do
  before(:each) do
    admin = assign(:current_user, FactoryGirl.create(:admin))
    sign_in admin
    quotes = FactoryGirl.create_list(:quote_proposal, 4)
    paginated_quotes = Kaminari.paginate_array(quotes).page(1)
    decorated_quotes = QuoteProposalDecorator.decorate_collection(paginated_quotes)
    assign(:quote_proposals, decorated_quotes)
  end

  it 'renders a list of quote_proposals' do
    render
  end
end
