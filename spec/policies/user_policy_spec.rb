require 'spec_helper'

describe UserPolicy do
  let(:admin) { FactoryGirl.create(:admin, email: "#{Faker::Internet::email}") }
  let(:country_manager) { FactoryGirl.create(:country_manager, country: 'Spain', email: "#{Faker::Internet::email}") }
  let(:spanish_owner) { FactoryGirl.create(:user, country: 'Spain', email: "#{Faker::Internet::email}") }
  let(:another_owner) { FactoryGirl.create(:user, country: 'Albania', email: "#{Faker::Internet::email}") }

  context "for an admin" do
    context "over a country manager" do
      subject { UserPolicy.new(admin, country_manager) }
      it { should allow_action(:index) }
      it { should allow_action(:create) }
      it { should allow_action(:new) }
      it { should allow_action(:update) }
      it { should allow_action(:edit) }
      it { should allow_action(:destroy) }
    end

    context "over a user" do
      subject { UserPolicy.new(admin, spanish_owner) }
      it { should allow_action(:index) }
      it { should allow_action(:create) }
      it { should allow_action(:new) }
      it { should allow_action(:update) }
      it { should allow_action(:edit) }
      it { should allow_action(:destroy) }
    end
  end

  context "for a country_manager" do
    context "and an user of his country" do
      subject { UserPolicy.new(country_manager, spanish_owner) }
      it { should_not allow_action(:create) }
      it { should_not allow_action(:new) }
      it { should_not allow_action(:destroy) }
      it { should allow_action(:index) }
      it { should allow_action(:show) }
      it { should allow_action(:edit) }
      it { should allow_action(:update) }
    end
    context "and an user of another country" do
      subject { UserPolicy.new(country_manager, another_owner) }
      it { should_not allow_action(:create) }
      it { should_not allow_action(:new) }
      it { should_not allow_action(:destroy) }
      it { should_not allow_action(:index) }
      it { should_not allow_action(:show) }
      it { should_not allow_action(:edit) }
      it { should_not allow_action(:update) }
    end
  end

  context "for an owner" do
    context "over himself" do
      subject { UserPolicy.new(spanish_owner, spanish_owner) }
      it { should allow_action(:show) }
      it { should allow_action(:edit) }
      it { should allow_action(:update) }
      it { should_not allow_action(:index) }
      it { should_not allow_action(:create) }
      it { should_not allow_action(:new) }
      it { should_not allow_action(:destroy) }
    end

    context "over a country manager" do
      subject { UserPolicy.new(spanish_owner, country_manager) }
      it { should_not allow_action(:show) }
      it { should_not allow_action(:edit) }
      it { should_not allow_action(:update) }
      it { should_not allow_action(:index) }
      it { should_not allow_action(:create) }
      it { should_not allow_action(:new) }
      it { should_not allow_action(:destroy) }
    end

    context "over another owner" do
      subject { UserPolicy.new(spanish_owner, another_owner) }
      it { should_not allow_action(:show) }
      it { should_not allow_action(:edit) }
      it { should_not allow_action(:update) }
      it { should_not allow_action(:index) }
      it { should_not allow_action(:create) }
      it { should_not allow_action(:new) }
      it { should_not allow_action(:destroy) }
    end
  end
end
