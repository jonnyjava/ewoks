# spec/factories.rb

FactoryGirl.define do
  factory :tyre_fee do
    fee { FactoryGirl.create(:fee) }
    vehicle_type TyreFee::VEHICLE_TYPE.to_a.sample[0]
    diameter_min Faker::Number.number(2)
    diameter_max Faker::Number.number(2)
    rim_type TyreFee::RIM_TYPE.to_a.sample[0]  end
end
