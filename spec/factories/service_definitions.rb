FactoryGirl.define do
  factory :service_definition do
    name { Faker::Commerce.product_name }

    factory :assigned_definition, class: ServiceDefinition do
      service { FactoryGirl.create(:service) }
    end
  end
end
