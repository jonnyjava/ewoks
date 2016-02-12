require 'spec_helper'

describe HolidayPolicy do
  let(:admin) { FactoryGirl.create(:admin) }
  let(:country_manager) { FactoryGirl.create(:country_manager) }
  let(:spanish_owner) { FactoryGirl.create(:user) }
  let(:spanish_garage) { FactoryGirl.create(:garage, country: 'Spain', owner_id: spanish_owner.id) }
  let(:another_garage) { FactoryGirl.create(:garage, country: 'Albania') }
  let(:holiday) { FactoryGirl.create(:holiday, garage: spanish_garage) }
  let(:someone_else_holiday) { FactoryGirl.create(:holiday, garage: another_garage) }

  context 'for an admin' do
    context 'over an holiday' do
      subject { HolidayPolicy.new(admin, holiday) }
      it { is_expected.to allow_action(:show) }
      it { is_expected.to allow_action(:index) }
      it { is_expected.to allow_action(:new) }
      it { is_expected.to allow_action(:create) }
      it { is_expected.to allow_action(:edit) }
      it { is_expected.to allow_action(:update) }
      it { is_expected.to allow_action(:destroy) }
    end
  end

  context 'for a country_manager' do
    context 'and an holiday of a garage in his country' do
      it 'contains holidays of garages of the same country of country_manager' do
        expect(Pundit.policy_scope(country_manager, Holiday).all)
          .to match_array Holiday.includes(:garage).where('garages.country = ?', country_manager.country).references(:garage)
      end
      subject { HolidayPolicy.new(country_manager, holiday) }
      it { is_expected.to allow_action(:show) }
      it { is_expected.to allow_action(:index) }
      it { is_expected.to allow_action(:new) }
      it { is_expected.to allow_action(:create) }
      it { is_expected.to allow_action(:edit) }
      it { is_expected.to allow_action(:update) }
      it { is_expected.to allow_action(:destroy) }
    end
    context 'and an holiday of a garage in another country' do
      subject { HolidayPolicy.new(country_manager, someone_else_holiday) }
      it { is_expected.not_to allow_action(:show) }
      it { is_expected.not_to allow_action(:new) }
      it { is_expected.not_to allow_action(:create) }
      it { is_expected.not_to allow_action(:edit) }
      it { is_expected.not_to allow_action(:update) }
      it { is_expected.not_to allow_action(:destroy) }
    end
  end

end
