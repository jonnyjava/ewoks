require 'spec_helper'

describe TimetablePolicy do
  let(:admin) { FactoryGirl.create(:admin) }
  let(:country_manager) { FactoryGirl.create(:country_manager) }
  let(:spanish_owner) { FactoryGirl.create(:user) }
  let(:api_user) { FactoryGirl.create(:api_user) }

  let(:spanish_garage) { FactoryGirl.create(:garage, country: 'Spain', owner_id: spanish_owner.id) }
  let(:another_garage) { FactoryGirl.create(:garage, country: 'Albania') }
  let(:timetable) { FactoryGirl.create(:timetable, garage: spanish_garage) }
  let(:someone_else_timetable) { FactoryGirl.create(:timetable, garage: another_garage) }

  shared_examples_for "someone fully authorized" do
    it { is_expected.not_to allow_action(:index) }
    it { is_expected.not_to allow_action(:show) }
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
    context 'over any timetable' do
      subject { TimetablePolicy.new(admin, timetable) }
      it_behaves_like "someone fully authorized"
    end
  end

  context 'for a country_manager' do
    context 'and timetable of a garage in his country' do
      it 'the scope contains timetable of garages of the same country of country_manager' do
        country = country_manager.country
        timetable = Timetable.includes(:garage).where('garages.country = ?', country)
        expect(Pundit.policy_scope(country_manager, Timetable).all).to match_array timetable.references(:garage)
      end
      subject { TimetablePolicy.new(country_manager, timetable) }
      it_behaves_like "someone fully authorized"
    end
    context 'and timetable of a garage in another country' do
      subject { TimetablePolicy.new(country_manager, someone_else_timetable) }
      it_behaves_like "someone totally unauthorized"
    end
  end

  context 'for an owner' do
    context 'over his timetable' do
      subject { TimetablePolicy.new(spanish_owner, timetable) }
      it_behaves_like "someone fully authorized"
    end

    context 'over someone else timetable' do
      subject { TimetablePolicy.new(spanish_owner, someone_else_timetable) }
      it_behaves_like "someone totally unauthorized"
    end
  end
  context 'for an api_user' do
    context 'over any timetable' do
      subject { TimetablePolicy.new(api_user, timetable) }
      it_behaves_like "someone totally unauthorized"
    end
  end
end
