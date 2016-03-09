FactoryGirl.define do
  factory :garage_recruitable do

    name                { "#{Faker::StarWars.planet}, #{Faker::StarWars.specie}" }
    street              { Faker::Address.street_address }
    zip                 { Faker::Number.number(5) }
    city                { Faker::Address.city }
    email               { Faker::Internet.safe_email(Faker::StarWars.character) }
    phone               { Faker::Number.number(10) }
    mobile              { Faker::Number.number(10) }
    tax_id              { "#{Faker::Lorem.characters(1).upcase}#{Faker::Number.number(8)}" }
    province            { Faker::Address.city }
    status              { GarageRecruitable.statuses.keys.sample }
  end
end
