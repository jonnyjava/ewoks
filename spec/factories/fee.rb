# spec/factories.rb

FactoryGirl.define do
  factory :fee do
    garage { FactoryGirl.create(:garage) }
    name   Faker::Commerce.department
    price  Faker::Number.number(3)
  end
end
