FactoryGirl.define do
  factory :service do
    name      { Faker::Commerce.department(1) }
    service_category { FactoryGirl.create(:service_category) }
  end
end
