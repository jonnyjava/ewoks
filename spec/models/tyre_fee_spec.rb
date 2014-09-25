require 'spec_helper'

describe TyreFee do
  it { should belong_to(:garage) }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:price) }
  it { should have_db_column(:price).with_options(precision: 4, scale: 2) }

  it 'should return only tyre fees of the choosen vehicle type' do
    TyreFee::VEHICLES.each do |vehicle|
      FactoryGirl.create(:tyre_fee, vehicle_type: TyreFee::VEHICLE_TYPE.key(vehicle))
    end
    random_vehicle = TyreFee::VEHICLE_TYPE.to_a.sample
    vehicle_id = random_vehicle[0]
    vehicle_type = random_vehicle[1]
    fees = TyreFee.by_vehicle(vehicle_type)
    fees.count.should be(1)
    fees.first.vehicle_type.should be(vehicle_id)
  end

  it 'should return only tyre fees of the choosen rim' do
    TyreFee::RIMS.each do |rim|
      FactoryGirl.create(:tyre_fee, rim_type: TyreFee::RIM_TYPE.key(rim))
    end
    random_rim = TyreFee::RIM_TYPE.to_a.sample
    rim_id = random_rim[0]
    rim_type = random_rim[1]
    fees = TyreFee.by_rim(rim_type)
    fees.count.should be(1)
    fees.first.rim_type.should be(rim_id)
  end
end
