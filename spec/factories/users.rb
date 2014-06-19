# spec/factories.rb

FactoryGirl.define do
  factory :user do
    email "#{Faker::Internet::email}"
    password "#{Faker::Internet::password}"

    factory :admin, class: User do
      role User::ADMIN
    end

    factory :country_manager, class: User do
      role User::COUNTRY_MANAGER
    end

    factory :owner, class: User do
      role User::OWNER
    end
  end
end