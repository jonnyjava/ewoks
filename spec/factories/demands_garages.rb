FactoryGirl.define do
  factory :demands_garage do
    garage_id           { FactoryGirl.create(:garage).id }
    demand_id           { FactoryGirl.create(:demand).id }
    quote_proposal_id   nil
  end
end
