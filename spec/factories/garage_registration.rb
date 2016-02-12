FactoryGirl.define do
  factory :garage_registration do
    garage_name           Faker::Name.name
    tax_id                Faker::Code.isbn
    street                Faker::Address.street_name
    zip                   Faker::Address.zip_code
    phone                 Faker::PhoneNumber.phone_number
    email                 { "#{Faker::Internet::email}" }
    password              'ilgattodellanonna'
  end
end
