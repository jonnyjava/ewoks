# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :timetable do
    garage { FactoryGirl.create(:garage) }
  end
end
