require 'spec_helper'

describe Demand do
  it { is_expected.to belong_to(:service_category) }
  it { is_expected.to belong_to(:service) }
  it { is_expected.to have_many(:quote_proposals).dependent(:destroy) }
  it { is_expected.to validate_presence_of(:city) }
  it { is_expected.to validate_presence_of(:name_and_surnames) }
  it { is_expected.to validate_presence_of(:phone) }
  it { is_expected.to validate_presence_of(:email) }


describe 'assignment to garages' do
      it 'should assign the demand only to garages offering the demanded service' do
        service = FactoryGirl.create(:service)
        target_garage = FactoryGirl.create(:garage)
        wrong_garage = FactoryGirl.create(:garage)
        target_garage.services << service

        FactoryGirl.create(:demand, service_id: service.id, service_category_id: service.service_category_id)

        expect(target_garage.demands.size).to eq(1)
        expect(wrong_garage.demands.size).to eq(0)
        expect(target_garage.demands.first.id).to eq(Demand.first.id)
      end
    end


end
