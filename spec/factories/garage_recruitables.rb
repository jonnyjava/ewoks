FactoryGirl.define do
  factory :garage_recruitable do

    name      Faker::StarWars.specie
    street    Faker::Address.street_name
    zip       Faker::Address.zip_code
    city      Faker::Address.city
    sequence(:email) { |n| "#{Faker::Internet.safe_email}_#{n}" }
    phone     Faker::PhoneNumber.phone_number
    mobile     Faker::PhoneNumber.phone_number
    sequence(:tax_id) { |n| "#{n}_#{Faker::Code.isbn}" }
    province  Faker::Address.city
    status    GarageRecruitable.statuses.keys.sample

    factory :recruitable, class: GarageRecruitable do
    status    GarageRecruitable.statuses.keys.first
    end
  end
end
