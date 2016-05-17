describe DemandsGarage do
  it { is_expected.to belong_to(:demand) }
  it { is_expected.to belong_to(:garage) }
  it { is_expected.to have_one(:quote_proposal) }
end
