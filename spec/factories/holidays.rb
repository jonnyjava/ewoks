# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :holiday do
    garage { FactoryGirl.create(:garage) }
    start_date '2014-12-24'
    end_date '2014-12-31'
    name 'Default holidays'
  end
end
