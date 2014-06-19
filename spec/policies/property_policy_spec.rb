require 'spec_helper'

describe PropertyPolicy do
  let(:admin) { FactoryGirl.create(:admin, email: "#{Faker::Internet::email}") }
  let(:country_manager) { FactoryGirl.create(:country_manager, country: 'Spain', email: "#{Faker::Internet::email}") }
  let(:owner) { FactoryGirl.create(:user, country: 'Spain', email: "#{Faker::Internet::email}") }
  let(:property) { FactoryGirl.create(:property) }

  context "for an admin" do
    subject { PropertyPolicy.new(admin, property) }
    it { should allow_action(:index) }
    it { should allow_action(:create) }
    it { should allow_action(:new) }
    it { should allow_action(:update) }
    it { should allow_action(:edit) }
    it { should allow_action(:destroy) }
  end

  context "for a country_manager" do
    subject { PropertyPolicy.new(country_manager, property) }
    it { should_not allow_action(:index) }
    it { should_not allow_action(:create) }
    it { should_not allow_action(:new) }
    it { should_not allow_action(:update) }
    it { should_not allow_action(:edit) }
    it { should_not allow_action(:destroy) }
  end

  context "for an owner" do
    subject { PropertyPolicy.new(owner, property) }
    it { should_not allow_action(:index) }
    it { should_not allow_action(:create) }
    it { should_not allow_action(:new) }
    it { should_not allow_action(:update) }
    it { should_not allow_action(:edit) }
    it { should_not allow_action(:destroy) }
  end
end