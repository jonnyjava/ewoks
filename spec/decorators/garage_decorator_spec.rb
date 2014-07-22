require 'spec_helper'
describe GarageDecorator do
  let(:garage_to_confirm) { FactoryGirl.create(:garage, status: Garage::TO_BE_CONFIRMED) }
  let(:garage_active) { FactoryGirl.create(:garage, status: Garage::ACTIVE) }
  let(:garage_disabled) { FactoryGirl.create(:garage, status: Garage::INACTIVE) }

  it{ garage_to_confirm.decorate.status.should eq('to_confirm') }
  it{ garage_active.decorate.status.should eq('enabled') }
  it{ garage_disabled.decorate.status.should eq('disabled') }
end
