require 'spec_helper'

describe DemandPolicy do
  let(:admin) { FactoryGirl.create(:admin) }
  let(:country_manager) { FactoryGirl.create(:country_manager) }
  let(:owner) { FactoryGirl.create(:owner) }
  let(:api_user) { FactoryGirl.create(:api_user) }
  let(:demand) { FactoryGirl.create(:demand) }

  shared_examples_for "someone not authorized" do
    it { is_expected.not_to allow_action(:new) }
    it { is_expected.not_to allow_action(:edit) }
    it { is_expected.not_to allow_action(:update) }
    it { is_expected.not_to allow_action(:destroy) }
  end

  context "for an admin" do
    subject { DemandPolicy.new(admin, demand) }
    it_behaves_like "someone not authorized"
    it { is_expected.to allow_action(:index) }
    it { is_expected.to allow_action(:show) }
    it { is_expected.not_to allow_action(:create) }
  end

  context "for a country_manager" do
    subject { DemandPolicy.new(country_manager, demand) }
    it_behaves_like "someone not authorized"
    it { is_expected.not_to allow_action(:index) }
    it { is_expected.not_to allow_action(:show) }
    it { is_expected.not_to allow_action(:create) }
  end

  context "for a owner" do
    subject { DemandPolicy.new(owner, demand) }
    it_behaves_like "someone not authorized"
    it { is_expected.to allow_action(:index) }
    it { is_expected.to allow_action(:show) }
    it { is_expected.not_to allow_action(:create) }
  end

  context "for an api_user" do
    subject { DemandPolicy.new(api_user, demand) }
    it_behaves_like "someone not authorized"
    it { is_expected.not_to allow_action(:index) }
    it { is_expected.not_to allow_action(:show) }
    it { is_expected.to allow_action(:create) }
  end
end
