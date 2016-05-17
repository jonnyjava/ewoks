describe ApplicationDecorator do
  let(:garage) { FactoryGirl.create(:garage) }
  let(:holiday) { FactoryGirl.create(:holiday) }

  it{ expect(garage.decorate.pathify('action')).to eq('action_garage_path') }
  it{ expect(garage.decorate.pathify('')).to eq('garage_path') }
  it{ expect(holiday.decorate.pathify('action', garage)).to eq('action_garage_holiday_path') }
  it{ expect(holiday.decorate.pathify('', garage)).to eq('garage_holiday_path') }
end
