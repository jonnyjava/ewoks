describe ServicePolicy do
  let(:admin) { FactoryGirl.create(:admin) }
  let(:country_manager) { FactoryGirl.create(:country_manager) }
  let(:owner) { FactoryGirl.create(:owner) }
  let(:api_user) { FactoryGirl.create(:api_user) }
  let(:service) { FactoryGirl.create(:service) }

  shared_examples_for "not authorized on anything except index" do
    it { is_expected.not_to allow_action(:show) }
    it { is_expected.not_to allow_action(:new) }
    it { is_expected.not_to allow_action(:create) }
    it { is_expected.not_to allow_action(:edit) }
    it { is_expected.not_to allow_action(:update) }
    it { is_expected.not_to allow_action(:destroy) }
  end

  context "for an admin" do
    subject { ServicePolicy.new(admin, service) }
    it { is_expected.not_to allow_action(:show) }
    it { is_expected.not_to allow_action(:new) }
    it { is_expected.not_to allow_action(:create) }
    it { is_expected.not_to allow_action(:destroy) }
    it { is_expected.not_to allow_action(:index) }
    it { is_expected.to allow_action(:edit) }
    it { is_expected.to allow_action(:update) }
  end

  context "for a country_manager" do
    subject { ServicePolicy.new(country_manager, service) }
    it_behaves_like "not authorized on anything except index"
    it { is_expected.not_to allow_action(:index) }
  end

  context "for a owner" do
    subject { ServicePolicy.new(owner, service) }
    it_behaves_like "not authorized on anything except index"
    it { is_expected.to allow_action(:index) }
  end

  context "for an api_user" do
    subject { ServicePolicy.new(api_user, service) }
    it_behaves_like "not authorized on anything except index"
    it { is_expected.not_to allow_action(:index) }
  end
end
