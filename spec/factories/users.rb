# spec/factories.rb

FactoryGirl.define do
  factory :user do
    name      { Faker::Name.name }
    email     { "#{Faker::Internet::email}" }
    password  '12345678'
    country   'Spain'

    factory :admin, class: User do
      role 'admin'
    end

    factory :country_manager, class: User do
      role 'country_manager'
    end

    factory :owner, class: User do
      role 'owner'
    end

    factory :api_user, class: User do
      role 'api'
    end
  end
end
