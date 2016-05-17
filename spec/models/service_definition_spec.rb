describe ServiceDefinition do
  it { is_expected.to belong_to(:service) }
  it { is_expected.to validate_presence_of(:name) }
end