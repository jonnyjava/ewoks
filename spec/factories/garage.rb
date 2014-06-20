# spec/factories.rb

FactoryGirl.define do
  factory :garage do
    street   Faker::Address.street_name
    zip       Faker::Address.zip_code
    city      Faker::Address.city
    country   Faker::Address.country
    phone     Faker::PhoneNumber.phone_number
    tax_id    Faker::Code.isbn
  end
end
