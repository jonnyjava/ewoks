# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :holiday do
    garage      { FactoryGirl.create(:garage) }
    start_date  "2014-05-28"
    end_date    "2014-05-28"
  end
end
