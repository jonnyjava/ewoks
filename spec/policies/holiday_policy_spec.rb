require 'spec_helper'

describe HolidayPolicy do
  let(:admin) { FactoryGirl.create(:admin) }
  let(:country_manager) { FactoryGirl.create(:country_manager) }
  let(:spanish_owner) { FactoryGirl.create(:user) }
  let(:spanish_garage) { FactoryGirl.create(:garage, country: 'Spain', owner_id: spanish_owner.id) }
  let(:holiday) { FactoryGirl.create(:holiday, garage: spanish_garage) }
  let(:someone_else_holiday) { FactoryGirl.create(:holiday) }

  context "for an admin" do
    context "over an holiday" do
      subject { HolidayPolicy.new(admin, holiday) }
      it { should allow_action(:show) }
      it { should allow_action(:index) }
      it { should allow_action(:new) }
      it { should allow_action(:create) }
      it { should allow_action(:edit) }
      it { should allow_action(:update) }
      it { should allow_action(:destroy) }
    end
  end

  context "for a country_manager" do
    context "and an holiday of a garage in his country" do
      subject { HolidayPolicy.new(country_manager, holiday) }
      it { should allow_action(:show) }
      it { should allow_action(:index) }
      it { should allow_action(:new) }
      it { should allow_action(:create) }
      it { should allow_action(:edit) }
      it { should allow_action(:update) }
      it { should allow_action(:destroy) }
    end
    context "and an holiday of a garage in another country" do
      subject { HolidayPolicy.new(country_manager, someone_else_holiday) }
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
