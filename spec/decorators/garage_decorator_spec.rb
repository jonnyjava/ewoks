describe GarageDecorator do
  let(:holiday) { FactoryGirl.create(:holiday) }
  let(:tyre_fee) { FactoryGirl.create(:tyre_fee) }
  let(:timetable) { FactoryGirl.create(:timetable) }
  let(:garage) { FactoryGirl.create(:garage) }
  let(:garage_disabled) { FactoryGirl.create(:garage, status: 'inactive') }
  let(:garage_to_confirm) { FactoryGirl.create(:garage, status: 'to_confirm') }
  let(:garage_completed) { FactoryGirl.create(:garage, holidays: [holiday], tyre_fees: [tyre_fee], timetable: timetable) }

  it 'should detect which data of garage are incomplete' do
    response = garage.decorate.notifications
    expect(response).to have_selector('li', count: 2)
  end

  it 'should detect which data of garage are complete' do
    garage_completed.services << FactoryGirl.create(:service)
    response = garage_completed.decorate.notifications
    expect(response).to be_nil
  end
end
