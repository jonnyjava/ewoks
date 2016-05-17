describe ServiceDefinitionPolicy do
  let(:admin) { FactoryGirl.create(:admin) }
  let(:country_manager) { FactoryGirl.create(:country_manager) }
  let(:owner) { FactoryGirl.create(:owner) }
  let(:api_user) { FactoryGirl.create(:api_user) }
  let(:service_definition) { FactoryGirl.create(:service_definition) }

  shared_examples_for "someone authorized" do
    it { is_expected.to allow_action(:index) }
    it { is_expected.not_to allow_action(:show) }
    it { is_expected.to allow_action(:new) }
    it { is_expected.to allow_action(:create) }
    it { is_expected.not_to allow_action(:edit) }
    it { is_expected.to allow_action(:update) }
    it { is_expected.to allow_action(:destroy) }
  end

  shared_examples_for "someone not authorized" do
    it { is_expected.not_to allow_action(:index) }
    it { is_expected.not_to allow_action(:show) }
    it { is_expected.not_to allow_action(:new) }
    it { is_expected.not_to allow_action(:create) }
    it { is_expected.not_to allow_action(:edit) }
    it { is_expected.not_to allow_action(:update) }
    it { is_expected.not_to allow_action(:destroy) }
  end

  context "for an admin" do
    subject { ServiceDefinitionPolicy.new(admin, service_definition) }
    it_behaves_like "someone authorized"
  end

  context "for a country_manager" do
    subject { ServiceDefinitionPolicy.new(country_manager, service_definition) }
    it_behaves_like "someone not authorized"
  end

  context "for a owner" do
    subject { ServiceDefinitionPolicy.new(owner, service_definition) }
    it_behaves_like "someone not authorized"
  end

  context "for an api_user" do
    subject { ServiceDefinitionPolicy.new(api_user, service_definition) }
    it_behaves_like "someone not authorized"
  end
end
