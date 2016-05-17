FactoryGirl.define do
  factory :service_definition do
    name { Faker::Commerce.product_name }
    service nil
  end
end
