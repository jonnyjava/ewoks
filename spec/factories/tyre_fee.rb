# spec/factories.rb

FactoryGirl.define do
  factory :tyre_fee do
    garage { FactoryGirl.create(:garage) }
    name Faker::Commerce.department
    price Faker::Commerce.price
    vehicle_type TyreFee::VEHICLE_TYPE.to_a.sample[0]
    diameter_min TyreFee::DIAMETER.to_a.sample
    diameter_max TyreFee::DIAMETER.to_a.sample
    rim_type TyreFee::RIM_TYPE.to_a.sample[0]
  end
end
