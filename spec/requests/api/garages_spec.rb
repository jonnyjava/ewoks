require 'spec_helper'

describe 'Garages' do

  def token_header(token)
    ActionController::HttpAuthentication::Token.encode_credentials(token)
  end


  let!(:user) { FactoryGirl.create(:user) }
  describe 'index' do
    it 'should return status 200' do
      api_get 'garages.json', {}, { 'Authorization' => token_header(user.auth_token) }
      response.status.should be(200)
      response.body.should_not be_empty
      response.content_type.should == Mime::JSON
    end

    it 'should return status 401' do
      api_get 'garages.json', {}, { 'Authorization' => "Token token=wrongtoken"}
      response.status.should be(401)
    end

    context 'with querystring' do
      let!(:spanish_garage) { FactoryGirl.create(:garage, country: 'Spain', zip: '00000', city: 'Valencia') }
      let!(:french_garage) { FactoryGirl.create(:garage, country: 'France', zip: '111111', city: 'Marseille') }
      let(:spanish_fee) { FactoryGirl.create(:fee, garage: spanish_garage, price: 20) }
      let(:french_fee) { FactoryGirl.create(:fee, garage: french_garage, price: 50) }

      it 'should filter by country' do
        api_get 'garages.json?country=Spain', {}, { 'Authorization' => token_header(user.auth_token) }
        response.status.should be(200)
        ids = json(response.body).collect { |g| g[:id] }
        ids.count.should be(1)
        ids.should include(spanish_garage.id)
        ids.should_not include(french_garage.id)
      end

      it 'should filter by zip' do
        api_get 'garages.json?zip=00000', {}, { 'Authorization' => token_header(user.auth_token) }
        response.status.should be(200)
        ids = json(response.body).collect { |g| g[:id] }
        ids.count.should be(1)
        ids.should include(spanish_garage.id)
        ids.should_not include(french_garage.id)
      end

      it 'should filter by city' do
        api_get 'garages.json?city=Valencia', {}, { 'Authorization' => token_header(user.auth_token) }
        response.status.should be(200)
        ids = json(response.body).collect { |g| g[:id] }
        ids.count.should be(1)
        ids.should include(spanish_garage.id)
        ids.should_not include(french_garage.id)
      end

      it 'should filter by tyre_fee' do
        spanish_fee
        french_fee
        api_get 'garages.json?tyre_fee=25', {}, { 'Authorization' => token_header(user.auth_token) }
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

        api_get 'garages.json?country=Spain&zip=00000&tyre_fee=25', {}, { 'Authorization' => token_header(user.auth_token) }
        response.status.should be(200)
        ids = json(response.body).collect { |g| g[:id] }
        ids.count.should be(1)
        ids.should include(spanish_garage.id)
        ids.should_not include(french_garage.id)
      end
    end

    context 'with radius search' do
      let!(:garage_inside_radius) { FactoryGirl.create(:turin_garage) }
      let!(:garage_outside_radius) { FactoryGirl.create(:rome_garage) }
      let(:outside_coords) { { latitude: 41.8084, longitude: 12.3015 } }
      before(:each) do
        garage_outside_radius.update_attributes(outside_coords)
      end

      it 'should return one garage searching by city' do
        api_get 'garages.json?country=Italy&city=Torino&radius=20', {}, { 'Authorization' => token_header(user.auth_token) }
        response.status.should be(200)
        ids = json(response.body).collect { |g| g[:id] }
        ids.count.should be(1)
        ids.should include(garage_inside_radius.id)
        ids.should_not include(garage_outside_radius.id)
      end

      it 'should return one garage searching by zip' do
        api_get 'garages.json?country=Italy&city=10139&radius=20', {}, { 'Authorization' => token_header(user.auth_token) }
        response.status.should be(200)
        ids = json(response.body).collect { |g| g[:id] }
        ids.count.should be(1)
        ids.should include(garage_inside_radius.id)
        ids.should_not include(garage_outside_radius.id)
      end
    end
  end
end
