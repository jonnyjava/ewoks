describe HolidayPolicy do
  let(:admin) { FactoryGirl.create(:admin) }
  let(:country_manager) { FactoryGirl.create(:country_manager) }
  let(:spanish_owner) { FactoryGirl.create(:user) }
  let(:spanish_garage) { FactoryGirl.create(:garage, country: 'Spain', owner_id: spanish_owner.id) }
  let(:another_garage) { FactoryGirl.create(:garage, country: 'Albania') }
  let(:holidays) { FactoryGirl.create(:holiday, garage: spanish_garage) }
  let(:someone_else_holiday) { FactoryGirl.create(:holiday, garage: another_garage) }
  let(:api_user) { FactoryGirl.create(:api_user) }

  shared_examples_for "someone fully authorized" do
    it { is_expected.to allow_action(:show) }
    it { is_expected.to allow_action(:index) }
    it { is_expected.to allow_action(:new) }
    it { is_expected.to allow_action(:create) }
    it { is_expected.to allow_action(:edit) }
    it { is_expected.to allow_action(:update) }
    it { is_expected.to allow_action(:destroy) }
  end

  shared_examples_for "someone totally unauthorized" do
    it { is_expected.not_to allow_action(:show) }
    it { is_expected.not_to allow_action(:index) }
    it { is_expected.not_to allow_action(:new) }
    it { is_expected.not_to allow_action(:create) }
    it { is_expected.not_to allow_action(:edit) }
    it { is_expected.not_to allow_action(:update) }
    it { is_expected.not_to allow_action(:destroy) }
  end

  context 'for an admin' do
    context 'over any holidays' do
      subject { HolidayPolicy.new(admin, holidays) }
      it_behaves_like "someone fully authorized"
    end
  end

  context 'for a country_manager' do
    context 'and holidays of a garage in his country' do
      it 'contains holidays of garages of the same country of country_manager' do
        country = country_manager.country
        holidays = Holiday.includes(:garage).where('garages.country = ?', country)
        expect(Pundit.policy_scope(country_manager, Holiday).all).to match_array holidays.references(:garage)
      end
      subject { HolidayPolicy.new(country_manager, holidays) }
      it_behaves_like "someone fully authorized"
    end
    context 'and holidays of a garage in another country' do
      subject { HolidayPolicy.new(country_manager, someone_else_holiday) }
      it_behaves_like "someone totally unauthorized"
    end
  end

  context 'for an owner' do
    context 'over his holidays' do
      subject { HolidayPolicy.new(spanish_owner, holidays) }
      it_behaves_like "someone fully authorized"
    end

    context 'over some one else holidays' do
      subject { HolidayPolicy.new(spanish_owner, someone_else_holiday) }
      it_behaves_like "someone totally unauthorized"
    end
  end
  context 'for an api_user' do
    context 'over any holidays' do
      subject { HolidayPolicy.new(api_user, holidays) }
      it_behaves_like "someone totally unauthorized"
    end
  end
end
