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

    factory :spanish_fee, class: TyreFee do
      garage { FactoryGirl.create(:spanish_garage) }
      price 20
      rim_type TyreFee::RIM_TYPE.key('steel')
      vehicle_type TyreFee::VEHICLE_TYPE.key('tourism')
      diameter_min 20
      diameter_max 30
    end

    factory :french_fee, class: TyreFee do
      garage { FactoryGirl.create(:french_garage) }
      price 50
      rim_type TyreFee::RIM_TYPE.key('aluminium')
      vehicle_type TyreFee::VEHICLE_TYPE.key('suv')
      diameter_min 10
      diameter_max 19
    end
  end
end
