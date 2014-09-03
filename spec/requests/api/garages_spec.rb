require 'spec_helper'

describe 'Garages' do

  def token_header(token)
    ActionController::HttpAuthentication::Token.encode_credentials(token)
  end

  describe 'index' do
    before(:each) do
      user = FactoryGirl.create(:api_user)
      @auth_token = { 'Authorization' => token_header(user.auth_token) }
    end

    it 'should return status 200' do
      api_get 'garages.json', {}, @auth_token
      response.status.should be(200)
      response.body.should_not be_empty
      response.content_type.should == Mime::JSON
    end

    it 'should return status 404' do
      api_get 'alderaan.json', {}, @auth_token
      response.status.should be(404)
      response.body.should_not be_empty
      response.content_type.should == Mime::JSON
    end

    it 'should return status 401' do
      api_get 'garages.json', {}, 'Authorization' => 'Token token=wrongtoken'

      response.status.should be(401)
    end

    context 'with querystring' do
      let(:spanish_garage) { FactoryGirl.create(:spanish_garage) }
      let(:french_garage) { FactoryGirl.create(:french_garage) }
      let!(:spanish_fee) { FactoryGirl.create(:spanish_fee, garage: spanish_garage) }
      let!(:french_fee) { FactoryGirl.create(:french_fee, garage: french_garage) }

      it 'should filter by country' do
        api_get 'garages.json?country=Spain', {}, @auth_token
        check_response(response)
      end

      it 'should filter by zip' do
        api_get 'garages.json?zip=00000', {}, @auth_token
        check_response(response)
      end

      it 'should filter by city' do
        api_get 'garages.json?city=Valencia', {}, @auth_token
        check_response(response)
      end

      context 'containing tyre_fee params ' do

        it 'should filter by price' do
          api_get 'garages.json?price=20', {}, @auth_token
          check_response(response)
        end

        it 'should filter by rim' do
          api_get 'garages.json?rim=steel', {}, @auth_token
          check_response(response)
        end

        it 'should filter by vehicle' do
          api_get 'garages.json?vehicle=tourism', {}, @auth_token
          check_response(response)
        end

        it 'should filter by diameter' do
          api_get 'garages.json?diameter=25', {}, @auth_token
          check_response(response)
        end

        it 'should filter by country, zip and price' do
          another_garage = FactoryGirl.create(:spanish_garage, zip: '00000')
          FactoryGirl.create(:tyre_fee, garage: another_garage, price: 40)
          api_get 'garages.json?country=Spain&zip=00000&price=20', {}, @auth_token
          check_response(response)
        end

        context 'filtering a range of prices' do
          it 'should filter by price in a range' do
            api_get 'garages.json?price_min=10&price_max=30', {}, @auth_token
            check_response(response)
          end

          it 'should filter by_price_in_a_range passing only min_price' do
            api_get 'garages.json?price_min=20', {}, @auth_token
            check_response(response)
          end

          it 'should filter by_price_in_a_range passing only max_price' do
            api_get 'garages.json?price_max=30', {}, @auth_token
            check_response(response)
          end

          it 'should filter by_price_in_a_range returning nothing if passing empty values' do
            api_get 'garages.json?price_min=&price_max=', {}, @auth_token
            response.status.should be(200)
            ids = json(response.body).map { |g| g[:id] }
            ids.count.should be(0)
          end
        end
      end

      def check_response(response)
        response.status.should be(200)
        ids = json(response.body).map { |g| g[:id] }
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
        api_get 'garages.json?country=Italy&city=Torino&radius=20', {}, @auth_token
        response.status.should be(200)
        ids = json(response.body).map { |g| g[:id] }
        ids.count.should be(1)
        ids.should include(garage_inside_radius.id)
        ids.should_not include(garage_outside_radius.id)
      end

      it 'should return one garage searching by zip' do
        api_get 'garages.json?country=Italy&city=10139&radius=20', {}, @auth_token
        response.status.should be(200)
        ids = json(response.body).map { |g| g[:id] }
        ids.count.should be(1)
        ids.should include(garage_inside_radius.id)
        ids.should_not include(garage_outside_radius.id)
      end
    end
  end
end
