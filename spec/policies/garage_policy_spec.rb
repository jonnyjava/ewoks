require 'spec_helper'

describe GaragePolicy do
  let(:admin) { FactoryGirl.create(:admin, email: "#{Faker::Internet::email}") }
  let(:country_manager) { FactoryGirl.create(:country_manager, country: 'Spain', email: "#{Faker::Internet::email}") }
  let(:spanish_owner) { FactoryGirl.create(:user, country: 'Spain', email: "#{Faker::Internet::email}") }
  let(:spanish_garage) { FactoryGirl.create(:garage, country: 'Spain', owner_id: spanish_owner.id) }
  let(:another_garage) { FactoryGirl.create(:garage, country: 'Burundi') }

  context "for an admin" do
    subject { GaragePolicy.new(admin, spanish_garage) }
    it { should allow_action(:show) }
    it { should allow_action(:index) }
    it { should allow_action(:new) }
    it { should allow_action(:create) }
    it { should allow_action(:edit) }
    it { should allow_action(:update) }
    it { should allow_action(:destroy) }
  end

  context "for a country_manager" do
    context "over a garage of his country" do
      subject { GaragePolicy.new(country_manager, spanish_garage) }
      it { should allow_action(:show) }
      it { should allow_action(:index) }
      it { should allow_action(:new) }
      it { should allow_action(:create) }
      it { should allow_action(:edit) }
      it { should allow_action(:update) }
      it { should_not allow_action(:destroy) }
    end

    context "over a garage of another country" do
      subject { GaragePolicy.new(country_manager, another_garage) }
      it { should_not allow_action(:show) }
      it { should_not allow_action(:index) }
      it { should_not allow_action(:new) }
      it { should_not allow_action(:create) }
      it { should_not allow_action(:edit) }
      it { should_not allow_action(:update) }
      it { should_not allow_action(:destroy) }
    end
  end

  context "for an owner" do
    context "over his own garage" do
      subject { GaragePolicy.new(spanish_owner, spanish_garage) }
      it { should allow_action(:show) }
      it { should_not allow_action(:index) }
      it { should allow_action(:edit) }
      it { should allow_action(:update) }
      it { should_not allow_action(:new) }
      it { should_not allow_action(:create) }
      it { should_not allow_action(:destroy) }
    end

    context "over another garage " do
      subject { GaragePolicy.new(spanish_owner, another_garage) }
      it { should_not allow_action(:show) }
      it { should_not allow_action(:index) }
      it { should_not allow_action(:new) }
      it { should_not allow_action(:create) }
      it { should_not allow_action(:edit) }
      it { should_not allow_action(:update) }
      it { should_not allow_action(:destroy) }
    end
  end
end