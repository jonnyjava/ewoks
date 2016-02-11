require 'spec_helper'

describe PropertyPolicy do
  let(:admin) { FactoryGirl.create(:admin) }
  let(:country_manager) { FactoryGirl.create(:country_manager) }
  let(:owner) { FactoryGirl.create(:user) }
  let(:property) { FactoryGirl.create(:property) }

  context "for an admin" do
    subject { PropertyPolicy.new(admin, property) }
    it { is_expected.to allow_action(:index) }
    it { is_expected.to allow_action(:show) }
    it { is_expected.to allow_action(:create) }
    it { is_expected.to allow_action(:new) }
    it { is_expected.to allow_action(:update) }
    it { is_expected.to allow_action(:edit) }
    it { is_expected.to allow_action(:destroy) }
  end

  context "for a country_manager" do
    subject { PropertyPolicy.new(country_manager, property) }
    it { is_expected.not_to allow_action(:index) }
    it { is_expected.not_to allow_action(:show) }
    it { is_expected.not_to allow_action(:create) }
    it { is_expected.not_to allow_action(:new) }
    it { is_expected.not_to allow_action(:update) }
    it { is_expected.not_to allow_action(:edit) }
    it { is_expected.not_to allow_action(:destroy) }
  end

  context "for an owner" do
    subject { PropertyPolicy.new(owner, property) }
    it { is_expected.not_to allow_action(:index) }
    it { is_expected.not_to allow_action(:show) }
    it { is_expected.not_to allow_action(:create) }
    it { is_expected.not_to allow_action(:new) }
    it { is_expected.not_to allow_action(:update) }
    it { is_expected.not_to allow_action(:edit) }
    it { is_expected.not_to allow_action(:destroy) }
  end
end
