require 'spec_helper'

describe 'Garages' do

  describe 'index' do
    it 'should return status 200' do
      get 'http://api.localhost.dev/garages'
      response.status.should be(200)
      response.body.should_not be_empty
    end
    context 'with querystring' do
      let!(:spanish_garage) { FactoryGirl.create(:garage, country: 'Spain', zip: '00000') }
      let!(:french_garage) { FactoryGirl.create(:garage, country: 'France', zip: '111111') }
      it 'filters a collection by country' do
        get 'http://api.localhost.dev/garages?country=Spain'
        response.status.should be(200)
        garages = json(response.body)
        ids = garages.collect { |g| g[:id] }
        ids.should include(spanish_garage.id)
        ids.should_not include(french_garage.id)
      end

      it 'filters a collection by country' do
        get 'http://api.localhost.dev/garages?zip=00000'
        response.status.should be(200)
        garages = json(response.body)
        ids = garages.collect { |g| g[:id] }
        ids.should include(spanish_garage.id)
        ids.should_not include(french_garage.id)
      end
    end
  end
end
