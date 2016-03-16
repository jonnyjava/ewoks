require 'spec_helper'

describe GaragePolicy do
  let(:admin) { FactoryGirl.create(:admin) }
  let(:country_manager) { FactoryGirl.create(:country_manager) }
  let(:spanish_owner) { FactoryGirl.create(:user) }
  let(:spanish_garage) { FactoryGirl.create(:garage, country: 'Spain', owner_id: spanish_owner.id) }
  let(:another_garage) { FactoryGirl.create(:garage, country: 'Burundi') }
  let(:api_user) { FactoryGirl.create(:api_user) }

  shared_examples_for "someone fully authorized" do
    it { is_expected.to allow_action(:show) }
    it { is_expected.to allow_action(:index) }
    it { is_expected.to allow_action(:new) }
    it { is_expected.to allow_action(:create) }
    it { is_expected.to allow_action(:edit) }
    it { is_expected.to allow_action(:update) }
    it { is_expected.to allow_action(:destroy_logo) }
    it { is_expected.to allow_action(:destroy) }
  end

  shared_examples_for "someone totally unauthorized" do
    it { is_expected.not_to allow_action(:show) }
    it { is_expected.not_to allow_action(:index) }
    it { is_expected.not_to allow_action(:new) }
    it { is_expected.not_to allow_action(:create) }
    it { is_expected.not_to allow_action(:edit) }
    it { is_expected.not_to allow_action(:update) }
    it { is_expected.not_to allow_action(:destroy_logo) }
    it { is_expected.not_to allow_action(:destroy) }
  end

  context "for an admin" do
    subject { GaragePolicy.new(admin, spanish_garage) }
    it_behaves_like "someone fully authorized"
  end

  context "for a country_manager" do
    context "over a garage of his country" do
      subject { GaragePolicy.new(country_manager, spanish_garage) }
      it_behaves_like "someone fully authorized"
    end

    context "over a garage of another country" do
      subject { GaragePolicy.new(country_manager, another_garage) }
      it { is_expected.not_to allow_action(:show) }
      it { is_expected.to allow_action(:index) }
      it { is_expected.not_to allow_action(:new) }
      it { is_expected.not_to allow_action(:create) }
      it { is_expected.not_to allow_action(:edit) }
      it { is_expected.not_to allow_action(:update) }
      it { is_expected.not_to allow_action(:destroy_logo) }
      it { is_expected.not_to allow_action(:destroy) }
    end
  end

  context "for an owner" do
    context "over his own garage" do
      subject { GaragePolicy.new(spanish_owner, spanish_garage) }
      it { is_expected.to allow_action(:show) }
      it { is_expected.not_to allow_action(:index) }
      it { is_expected.to allow_action(:edit) }
      it { is_expected.to allow_action(:update) }
      it { is_expected.not_to allow_action(:new) }
      it { is_expected.not_to allow_action(:create) }
      it { is_expected.to allow_action(:destroy_logo) }
      it { is_expected.not_to allow_action(:destroy) }
    end

    context "over another garage " do
      subject { GaragePolicy.new(spanish_owner, another_garage) }
      it_behaves_like "someone totally unauthorized"
    end
  end

  context "for an api_user" do
    subject { GaragePolicy.new(api_user, spanish_garage) }
    it_behaves_like "someone totally unauthorized"
  end
end
