require 'spec_helper'
describe GarageDecorator do
  let(:holiday) { FactoryGirl.create(:holiday) }
  let(:tyre_fee) { FactoryGirl.create(:tyre_fee) }
  let(:timetable) { FactoryGirl.create(:timetable) }
  let(:garage) { FactoryGirl.create(:garage) }
  let(:garage_disabled) { FactoryGirl.create(:garage, status: 'inactive') }
  let(:garage_to_confirm) { FactoryGirl.create(:garage, status: 'to_confirm') }
  let(:garage_completed) { FactoryGirl.create(:garage, holidays: [holiday], tyre_fees: [tyre_fee], timetable: timetable) }

  it { expect(garage_to_confirm.decorate.status).to eq('to_confirm') }
  it { expect(garage.decorate.status).to eq('enabled') }
  it { expect(garage_disabled.decorate.status).to eq('disabled') }

  it 'should detect which data of garage are incomplete' do
    response = garage.decorate.notifications
    expect(response).to have_selector('li', count: 2)
  end

  it 'should detect which data of garage are complete' do
    response = garage_completed.decorate.notifications
    expect(response).to be_nil
  end
end
