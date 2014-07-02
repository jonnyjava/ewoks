# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :timetable do
    day 1
    morning_opening "2014-07-02 11:47:01"
    morning_closing "2014-07-02 11:47:01"
    afternoon_opening "2014-07-02 11:47:01"
    afternoon_closing "2014-07-02 11:47:01"
    garage nil
  end
end
