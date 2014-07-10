require 'spec_helper'

describe ApplicationDecorator do
  let(:garage) { FactoryGirl.create(:garage) }
  let(:holiday) { FactoryGirl.create(:holiday) }

  it{ garage.decorate.pathify('action').should eq('action_garage_path') }
  it{ garage.decorate.pathify('').should eq('garage_path') }
  it{ holiday.decorate.pathify('action', garage).should eq('action_garage_holiday_path') }
  it{ holiday.decorate.pathify('', garage).should eq('garage_holiday_path') }
end
