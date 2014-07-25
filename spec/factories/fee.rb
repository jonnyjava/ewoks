# spec/factories.rb

FactoryGirl.define do
  factory :fee do
    garage { FactoryGirl.create(:garage) }
    name   Faker::Commerce.department
    price  Faker::Commerce.price
  end
end
