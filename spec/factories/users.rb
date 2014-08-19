# spec/factories.rb

FactoryGirl.define do
  factory :user do
    name      { Faker::Name.name }
    email     { "#{Faker::Internet::email}" }
    password  '12345678'
    country   'Spain'

    factory :admin, class: User do
      role User::ADMIN
    end

    factory :country_manager, class: User do
      role User::COUNTRY_MANAGER
    end

    factory :owner, class: User do
      role User::OWNER
    end

    factory :api_user, class: User do
      role User::API
    end
  end
end
