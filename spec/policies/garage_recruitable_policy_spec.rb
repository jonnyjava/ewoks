describe GarageRecruitablePolicy do
  let(:admin) { FactoryGirl.create(:admin) }
  let(:country_manager) { FactoryGirl.create(:country_manager) }
  let(:owner) { FactoryGirl.create(:owner) }
  let(:api_user) { FactoryGirl.create(:api_user) }
  let(:recruitable) { FactoryGirl.create(:garage_recruitable) }

  shared_examples_for "someone authorized" do
    it { is_expected.to allow_action(:show) }
    it { is_expected.to allow_action(:index) }
    it { is_expected.not_to allow_action(:new) }
    it { is_expected.to allow_action(:create) }
    it { is_expected.to allow_action(:edit) }
    it { is_expected.to allow_action(:update) }
    it { is_expected.to allow_action(:destroy) }
  end

  shared_examples_for "someone unauthorized" do
    it { is_expected.not_to allow_action(:index) }
    it { is_expected.not_to allow_action(:new) }
    it { is_expected.not_to allow_action(:create) }
    it { is_expected.not_to allow_action(:edit) }
    it { is_expected.not_to allow_action(:destroy) }
  end

  context "for an admin" do
    subject { GarageRecruitablePolicy.new(admin, recruitable) }
    it_behaves_like "someone authorized"
  end

  context "for an country manager" do
    subject { GarageRecruitablePolicy.new(country_manager, recruitable) }
    it_behaves_like "someone authorized"
  end

  context "for an owner" do
    subject { GarageRecruitablePolicy.new(owner, recruitable) }
    it_behaves_like "someone unauthorized"
    it { is_expected.not_to allow_action(:show) }
    it { is_expected.not_to allow_action(:update) }
  end

  context "for an api_user" do
    subject { GarageRecruitablePolicy.new(api_user, recruitable) }
    it_behaves_like "someone unauthorized"
    it { is_expected.to allow_action(:show) }
    it { is_expected.to allow_action(:update) }
  end
end
