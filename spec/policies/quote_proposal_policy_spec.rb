require 'spec_helper'

describe QuoteProposalPolicy do
  let(:admin) { FactoryGirl.create(:admin) }
  let(:country_manager) { FactoryGirl.create(:country_manager) }
  let(:owner) { FactoryGirl.create(:owner) }
  let(:garage) { FactoryGirl.create(:garage, user: owner) }
  let(:api_user) { FactoryGirl.create(:api_user) }
  let(:demands_garage) { FactoryGirl.create(:demands_garage, garage: garage) }
  let(:quote_proposal) { FactoryGirl.create(:quote_proposal, demands_garage: demands_garage) }
  let(:another_quote_proposal) { FactoryGirl.create(:quote_proposal) }

  shared_examples_for "someone authorized" do
    it { is_expected.to allow_action(:index) }
    it { is_expected.to allow_action(:show) }
    it { is_expected.to allow_action(:edit) }
    it { is_expected.to allow_action(:update) }
  end

  shared_examples_for "someone not authorized" do
    it { is_expected.not_to allow_action(:index) }
    it { is_expected.not_to allow_action(:show) }
    it { is_expected.not_to allow_action(:new) }
    it { is_expected.not_to allow_action(:create) }
    it { is_expected.not_to allow_action(:edit) }
    it { is_expected.not_to allow_action(:destroy) }
  end

  context "for an admin" do
    subject { QuoteProposalPolicy.new(admin, quote_proposal) }
    it_behaves_like "someone authorized"
    it { is_expected.not_to allow_action(:new) }
    it { is_expected.not_to allow_action(:create) }
    it { is_expected.to allow_action(:destroy) }
  end

  context "for a country_manager" do
    subject { QuoteProposalPolicy.new(country_manager, quote_proposal) }
    it_behaves_like "someone not authorized"
    it { is_expected.not_to allow_action(:update) }
  end

  context "for a owner" do
    context "over his quote_proposals" do
      subject { QuoteProposalPolicy.new(owner, quote_proposal) }
      it_behaves_like "someone authorized"
      it { is_expected.to allow_action(:new) }
      it { is_expected.to allow_action(:create) }
      it { is_expected.to allow_action(:destroy) }
    end
    context "over someone else quote_proposals" do
      subject { QuoteProposalPolicy.new(owner, another_quote_proposal) }
      it_behaves_like "someone not authorized"
    end
  end

  context "for an api_user" do
    subject { QuoteProposalPolicy.new(api_user, quote_proposal) }
    it_behaves_like "someone not authorized"
    it { is_expected.to allow_action(:update) }
  end
end
