describe QuoteProposal do
  let(:demand_garage) { FactoryGirl.create(:demands_garage) }
  let!(:quote_proposal) { FactoryGirl.create(:quote_proposal, demands_garage: demand_garage) }

  it { is_expected.to belong_to(:demand) }
  it { is_expected.to belong_to(:garage) }
  it { is_expected.to belong_to(:demands_garage) }
  it { is_expected.to validate_presence_of(:ttc_price) }

  it 'should update its demands_garage.quote_proposal_id with self.id' do
    expect(demand_garage.quote_proposal_id).to eq(quote_proposal.id)
  end

  it 'should have the same garage of its demands_garage' do
    expect(quote_proposal.garage).to eq(demand_garage.garage)
  end

  it 'should have the same demand of its demands_garage' do
    expect(quote_proposal.demand).to eq(demand_garage.demand)
  end
end
