describe Holiday do
  it { is_expected.to belong_to(:garage) }
  it { is_expected.to validate_presence_of(:start_date) }
end
