FactoryGirl.define do
  factory :garage_recruitable do

    name                { "#{Faker::StarWars.planet}-#{Faker::StarWars.specie}" }
    street              { Faker::Address.street_address }
    zip                 { Faker::Address.zip_code }
    city                { Faker::Address.city }
    email               { Faker::Internet.safe_email }
    phone               { Faker::PhoneNumber.phone_number }
    mobile              { Faker::PhoneNumber.cell_phone }
    tax_id              { "#{Faker::Lorem.characters(1).upcase}#{Faker::Code.isbn}" }
    province            { Faker::Address.city }
    status              GarageRecruitable.statuses.keys.sample

    factory :recruitable, class: GarageRecruitable do
        status GarageRecruitable.statuses.keys.first
    end
  end
end
