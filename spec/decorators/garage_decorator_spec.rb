require 'spec_helper'

describe GarageDecorator do
  let(:garage_active) { FactoryGirl.create(:garage, status: true) }
  let(:garage_disabled) { FactoryGirl.create(:garage, status: false) }

  it{ garage_active.decorate.status.should eq('active') }
  it{ garage_disabled.decorate.status.should eq('disable') }
end
