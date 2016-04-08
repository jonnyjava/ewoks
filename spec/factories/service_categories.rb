FactoryGirl.define do
  factory :service_category do
    name      { Faker::Commerce.department(1) }
  end
end
