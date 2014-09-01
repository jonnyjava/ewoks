require 'spec_helper'
describe GarageDecorator do
  let(:holiday) { FactoryGirl.create(:holiday) }
  let(:tyre_fee) { FactoryGirl.create(:tyre_fee) }
  let(:timetable) { FactoryGirl.create(:timetable) }
  let(:garage_active) { FactoryGirl.create(:garage, status: Garage::ACTIVE) }

  let(:garage_disabled) do
    FactoryGirl.create(:garage, status: Garage::INACTIVE)
  end
  let(:garage_to_confirm) do
    FactoryGirl.create(:garage, status: Garage::TO_BE_CONFIRMED)
  end
  let(:garage_completed) do
    FactoryGirl.create(:garage, holidays: [holiday],
      tyre_fees: [tyre_fee], timetable: timetable)
  end
  let(:garage_incompleted) do
    FactoryGirl.create(:garage)
  end

  it { garage_to_confirm.decorate.status.should eq('to_confirm') }
  it { garage_active.decorate.status.should eq('enabled') }
  it { garage_disabled.decorate.status.should eq('disabled') }

  it 'should detect which data of garage are incomplete' do
    response = garage_incompleted.decorate.notifications
    response.should have_selector('li', count: 3)
  end

  it 'should detect which data of garage are complete' do
    response = garage_completed.decorate.notifications
    response.should be_nil
  end
end
