# spec/factories.rb

FactoryGirl.define do
  factory :garage do
    status    Garage::ACTIVE
    name      Faker::Name.name
    street    Faker::Address.street_name
    zip       Faker::Address.zip_code
    city      Faker::Address.city
    country   Faker::Address.country
    phone     Faker::PhoneNumber.phone_number
    tax_id    Faker::Code.isbn
    latitude  Faker::Address.latitude
    longitude Faker::Address.longitude
    sequence(:email) {|n| Faker::Internet.safe_email(n) }

    factory :turin_garage, class: Garage do
      zip     '10141'
      city    'Torino'
      country 'Italy'
      street  'Via Monginevro 162'
      latitude 45.0647
      longitude 7.63015
    end

    factory :rome_garage, class: Garage do
      zip     '00054'
      city    'Roma'
      country 'Italy'
      street  'Via G. Ferraris 2/4'
      latitude 41.8084
      longitude 12.3015
    end

    factory :garage_with_timetable, class: Garage do
      timetable { FactoryGirl.create(:timetable) }
    end
  end
end
