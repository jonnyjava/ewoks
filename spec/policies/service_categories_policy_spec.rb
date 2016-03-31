require 'spec_helper'

describe ServiceCategoryPolicy do
  let(:admin) { FactoryGirl.create(:admin) }
  let(:country_manager) { FactoryGirl.create(:country_manager) }
  let(:owner) { FactoryGirl.create(:owner) }
  let(:api_user) { FactoryGirl.create(:api_user) }
  let(:service_category) { FactoryGirl.create(:service_category) }

  shared_examples_for "not authorized on anything except index" do
    it { is_expected.not_to allow_action(:show) }
    it { is_expected.not_to allow_action(:new) }
    it { is_expected.not_to allow_action(:create) }
    it { is_expected.not_to allow_action(:edit) }
    it { is_expected.not_to allow_action(:update) }
    it { is_expected.not_to allow_action(:destroy) }
  end

  context "for an admin" do
    subject { ServiceCategoryPolicy.new(admin, service_category) }
    it_behaves_like "not authorized on anything except index"
    it { is_expected.to allow_action(:index) }
  end

  context "for a country_manager" do
    subject { ServiceCategoryPolicy.new(country_manager, service_category) }
    it_behaves_like "not authorized on anything except index"
    it { is_expected.not_to allow_action(:index) }
  end

  context "for a owner" do
    subject { ServiceCategoryPolicy.new(owner, service_category) }
    it_behaves_like "not authorized on anything except index"
    it { is_expected.not_to allow_action(:index) }
  end

  context "for an api_user" do
    subject { ServiceCategoryPolicy.new(api_user, service_category) }
    it_behaves_like "not authorized on anything except index"
    it { is_expected.not_to allow_action(:index) }
  end

end