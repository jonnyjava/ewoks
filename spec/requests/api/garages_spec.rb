require 'spec_helper'

describe 'Garages' do

  describe 'index' do
    it 'should return status 200' do
      api_get 'garages'
      response.status.should be(200)
      response.body.should_not be_empty
    end
    context 'with querystring' do
      let!(:spanish_garage) { FactoryGirl.create(:garage, country: 'Spain', zip: '00000') }
      let!(:french_garage) { FactoryGirl.create(:garage, country: 'France', zip: '111111') }
      let(:spanish_fee) { FactoryGirl.create(:fee, garage: spanish_garage, price: 20) }
      let(:french_fee) { FactoryGirl.create(:fee, garage: french_garage, price: 50) }

      it 'should filter by country' do
        api_get 'garages?country=Spain'
        response.status.should be(200)
        ids = json(response.body).collect { |g| g[:id] }
        ids.count.should be(1)
        ids.should include(spanish_garage.id)
        ids.should_not include(french_garage.id)
      end

      it 'should filter by zip' do
        api_get 'garages?zip=00000'
        response.status.should be(200)
        ids = json(response.body).collect { |g| g[:id] }
        ids.count.should be(1)
        ids.should include(spanish_garage.id)
        ids.should_not include(french_garage.id)
      end

      it 'should filter by tyre_fee' do
        spanish_fee
        french_fee
        api_get 'garages?tyre_fee=25'
        response.status.should be(200)
        ids = json(response.body).collect { |g| g[:id] }
        ids.count.should be(1)
        ids.should include(spanish_garage.id)
        ids.should_not include(french_garage.id)
      end


      it 'should filter by country, zip and tyre_fee' do
        another_garage = FactoryGirl.create(:garage, country: 'Spain', zip: '00000')
        FactoryGirl.create(:fee, garage: another_garage, price: 40)
        spanish_fee
        french_fee

        api_get 'garages?country=Spain&zip=00000&tyre_fee=25'
        response.status.should be(200)
        ids = json(response.body).collect { |g| g[:id] }
        ids.count.should be(1)
        ids.should include(spanish_garage.id)
        ids.should_not include(french_garage.id)
      end
    end
  end
end
