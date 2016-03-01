FactoryGirl.define do
  factory :garage_recruitable do

    name      Faker::Name.name
    street    Faker::Address.street_name
    zip       Faker::Address.zip_code
    city      Faker::Address.city
    sequence(:email) { |n| "#{Faker::Internet.safe_email}_#{n}" }
    phone     Faker::PhoneNumber.phone_number
    mobile     Faker::PhoneNumber.phone_number
    tax_id    Faker::Code.isbn
    province  Faker::Address.city
    status    GarageRecruitable.statuses.keys.sample
  end
end
