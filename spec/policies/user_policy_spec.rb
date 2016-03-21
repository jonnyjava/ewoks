require 'spec_helper'

describe UserPolicy do
  let(:admin) { FactoryGirl.create(:admin) }
  let(:country_manager) { FactoryGirl.create(:country_manager) }
  let(:another_country_manager) { FactoryGirl.create(:country_manager, country: 'Albania') }
  let(:spanish_owner) { FactoryGirl.create(:user) }
  let(:another_owner) { FactoryGirl.create(:user, country: 'Albania') }
  let(:api_user) { FactoryGirl.create(:api_user) }

  shared_examples_for "someone fully authorized" do
    it { is_expected.to allow_action(:index) }
    it { is_expected.to allow_action(:show) }
    it { is_expected.to allow_action(:new) }
    it { is_expected.to allow_action(:edit) }
    it { is_expected.to allow_action(:create) }
    it { is_expected.to allow_action(:update) }
    it { is_expected.to allow_action(:destroy) }
    it { is_expected.to allow_action(:regenerate_auth_token) }
  end

  shared_examples_for "someone totally unauthorized" do
    it { is_expected.not_to allow_action(:index) }
    it { is_expected.not_to allow_action(:show) }
    it { is_expected.not_to allow_action(:new) }
    it { is_expected.not_to allow_action(:edit) }
    it { is_expected.not_to allow_action(:create) }
    it { is_expected.not_to allow_action(:update) }
    it { is_expected.not_to allow_action(:destroy) }
    it { is_expected.not_to allow_action(:regenerate_auth_token) }
  end

  shared_examples_for "someone authorized to show, edit and update but not to new, create or destroy" do
    it { is_expected.to allow_action(:show) }
    it { is_expected.not_to allow_action(:new) }
    it { is_expected.to allow_action(:edit) }
    it { is_expected.not_to allow_action(:create) }
    it { is_expected.to allow_action(:update) }
    it { is_expected.not_to allow_action(:destroy) }
  end

  context "for an admin" do
    context "over a country manager" do
      subject { UserPolicy.new(admin, country_manager) }
      it_behaves_like "someone fully authorized"
    end

    context "over a user" do
      subject { UserPolicy.new(admin, spanish_owner) }
      it_behaves_like "someone fully authorized"
    end

    context "over an api_user" do
      subject { UserPolicy.new(admin, api_user) }
      it_behaves_like "someone fully authorized"
    end
  end

  context 'for a country_manager' do
    it 'the scope contains users of the same country of country_manager' do
      country = country_manager.country
      owners_of_the_same_country = User.where(country: country, role: User::OWNER)
      expect(Pundit.policy_scope(country_manager, User).all).to match_array owners_of_the_same_country
    end

    context 'over an admin' do
      subject { UserPolicy.new(country_manager, admin) }
      it_behaves_like "someone totally unauthorized"
    end

    context 'over a country manager of another country' do
      subject { UserPolicy.new(country_manager, another_country_manager) }
      it_behaves_like "someone totally unauthorized"
    end

    context 'over an user of his country' do
      subject { UserPolicy.new(country_manager, spanish_owner) }
      it_behaves_like "someone authorized to show, edit and update but not to new, create or destroy"
      it { is_expected.to allow_action(:index) }
      it { is_expected.not_to allow_action(:regenerate_auth_token) }
    end

    context 'over an user of another country' do
      subject { UserPolicy.new(country_manager, another_owner) }
      it_behaves_like "someone totally unauthorized"
    end

    context "over an api_user" do
      subject { UserPolicy.new(country_manager, api_user) }
      it_behaves_like "someone totally unauthorized"
    end
  end

  context "for an owner" do
    context "over an admin" do
      subject { UserPolicy.new(spanish_owner, admin) }
      it_behaves_like "someone totally unauthorized"
    end

    context "over a country manager" do
      subject { UserPolicy.new(spanish_owner, country_manager) }
      it_behaves_like "someone totally unauthorized"
    end

    context "over himself" do
      subject { UserPolicy.new(spanish_owner, spanish_owner) }
      it_behaves_like "someone authorized to show, edit and update but not to new, create or destroy"
      it { is_expected.not_to allow_action(:index) }
      it { is_expected.not_to allow_action(:regenerate_auth_token) }
    end

    context "over api_user" do
      subject { UserPolicy.new(spanish_owner, api_user) }
      it_behaves_like "someone totally unauthorized"
    end

    context "over another owner" do
      subject { UserPolicy.new(spanish_owner, another_owner) }
      it_behaves_like "someone totally unauthorized"
    end
  end

  context "for an api_user" do
    context "over an admin" do
      subject { UserPolicy.new(api_user, admin) }
      it_behaves_like "someone totally unauthorized"
    end

    context "over a country manager" do
      subject { UserPolicy.new(api_user, country_manager) }
      it_behaves_like "someone totally unauthorized"
    end

    context "over a user" do
      subject { UserPolicy.new(api_user, spanish_owner) }
      it_behaves_like "someone totally unauthorized"
    end

    context "over himself" do
      subject { UserPolicy.new(api_user, api_user) }
      it_behaves_like "someone authorized to show, edit and update but not to new, create or destroy"
      it { is_expected.not_to allow_action(:index) }
      it { is_expected.to allow_action(:regenerate_auth_token) }
    end
  end
end
