# spec/factories.rb

FactoryGirl.define do
  factory :property do
    name     Faker::Lorem.word
    type_of  "String"
  end
end