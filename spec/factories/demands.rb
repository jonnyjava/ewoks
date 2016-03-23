FactoryGirl.define do
  factory :demand do
    city                { Faker::Address.city }
    service_category_id { FactoryGirl.create(:service_category).id }
    service_id          { FactoryGirl.create(:service).id }
    vin_number          { "#{Faker::Lorem.characters(4).upcase}#{Faker::Code.ean}" }
    brand               "Subaru"
    model               "Castaña"
    year                { Faker::Number.between(1980, 2016) }
    engine              { Faker::Beer.hop }
    engine_letters      { Faker::StarWars.droid }
    name_and_surnames   { "Mac #{Faker::StarWars.planet}asky, #{Faker::StarWars.specie}" }
    phone               { Faker::Number.number(10) }
    email               { Faker::Internet.safe_email(Faker::StarWars.character) }
    wants_newsletter    true
    accepts_privacy     true
    comments            { Faker::Hipster.sentence(4) }
    demand_details      "{'car_brand_id':'Ford','car_model_id':'Focus Focus CMax','car_year_id':'2006','car_engine_id':'1.8L 8V FWD','budget_id':'Todos los precios','budget_option':'Todos los precios'}"
  end
end
