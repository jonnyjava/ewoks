# spec/factories.rb

FactoryGirl.define do
  factory :garage do
    name      Faker::Name.name
    street    Faker::Address.street_name
    zip       Faker::Address.zip_code
    city      Faker::Address.city
    country   Faker::Address.country
    phone     Faker::PhoneNumber.phone_number
    tax_id    Faker::Code.isbn

    factory :garage_with_timetable, class: Garage do
      timetable { FactoryGirl.create(:timetable) }
    end
  end
end
