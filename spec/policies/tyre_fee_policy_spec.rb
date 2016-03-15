require 'spec_helper'

describe TyreFeePolicy do
  let(:admin) { FactoryGirl.create(:admin) }
  let(:country_manager) { FactoryGirl.create(:country_manager) }
  let(:spanish_owner) { FactoryGirl.create(:user) }
  let(:api_user) { FactoryGirl.create(:api_user) }

  let(:spanish_garage) { FactoryGirl.create(:garage, country: 'Spain', owner_id: spanish_owner.id) }
  let(:another_garage) { FactoryGirl.create(:garage, country: 'Albania') }
  let(:tyre_fee) { FactoryGirl.create(:tyre_fee, garage: spanish_garage) }
  let(:someone_else_tyre_fees) { FactoryGirl.create(:tyre_fee, garage: another_garage) }

  shared_examples_for "someone fully authorized" do
    it { is_expected.to allow_action(:index) }
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
    context 'over any tyre_fees' do
      subject { TyreFeePolicy.new(admin, tyre_fee) }
      it_behaves_like "someone fully authorized"
    end
  end

  context 'for a country_manager' do
    context 'and tyre_fees of a garage in his country' do
      it 'the scope contains tyre_fees of garages of the same country of country_manager' do
        country = country_manager.country
        tyre_fees = TyreFee.includes(:garage).where('garages.country = ?', country)
        expect(Pundit.policy_scope(country_manager, TyreFee).all).to match_array tyre_fees.references(:garage)
      end
      subject { TyreFeePolicy.new(country_manager, tyre_fee) }
      it_behaves_like "someone fully authorized"
    end
    context 'and tyre_fees of a garage in another country' do
      subject { TyreFeePolicy.new(country_manager, someone_else_tyre_fees) }
      it_behaves_like "someone totally unauthorized"
    end
  end

  context 'for an owner' do
    context 'over his tyre_fees' do
      subject { TyreFeePolicy.new(spanish_owner, tyre_fee) }
      it_behaves_like "someone fully authorized"
    end

    context 'over someone else tyre_fees' do
      subject { TyreFeePolicy.new(spanish_owner, someone_else_tyre_fees) }
      it_behaves_like "someone totally unauthorized"
    end
  end
  context 'for an api_user' do
    context 'over any tyre_fees' do
      subject { TyreFeePolicy.new(api_user, tyre_fee) }
      it_behaves_like "someone totally unauthorized"
    end
  end
end
