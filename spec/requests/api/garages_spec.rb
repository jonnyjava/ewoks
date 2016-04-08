require 'spec_helper'

describe 'Garages' do
  api_user_token

  describe 'index' do

    context 'with a valid token' do
      context 'with a valid json' do
        it 'should return status 200' do
          api_get 'garages.json', {}, @auth_token
          expect(response.status).to be(200)
          expect(response.body).not_to be_empty
          expect(response.content_type).to eq(Mime::JSON)
        end
      end

      context 'with an invalid json' do
        it 'should return status 404' do
          api_get 'alderaan.json', {}, @auth_token
          expect(response.status).to be(404)
          expect(response.body).not_to be_empty
          expect(response.content_type).to eq(Mime::JSON)
        end
      end
    end

    context 'with an invalid token' do
      it 'should return status 401' do
        api_get 'garages.json', {}, 'Authorization' => 'Token token=wrongtoken'
        expect(response.status).to be(401)
      end
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

      it 'should filter by service_id' do
        spanish_garage
        service = FactoryGirl.create(:service)
        spanish_garage.services << service

        another_spanish_garage = FactoryGirl.create(:spanish_garage)
        FactoryGirl.create(:spanish_fee, garage: another_spanish_garage)

        api_get "garages.json?service_id=#{service.id}", {}, @auth_token
        expect(response.status).to be(200)

        ids = json(response.body).map { |garage| garage[:id] }
        expect(ids.count).to be(1)
        expect(ids).to include(spanish_garage.id)
        expect(ids).not_to include(another_spanish_garage.id)
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
            expect(response.status).to be(200)
            ids = json(response.body).map { |g| g[:id] }
            expect(ids.count).to be(0)
          end
        end

        context 'searching inside a country' do
          it 'should return only garages of the country of the token owner' do
            api_get 'garages.json', {}, @auth_token
            check_response(response)
          end

          it 'should return only garages of the country of the token owner' do
            api_get 'garages.json?country=Spain&radius=5000', {}, @auth_token
            check_response(response)
          end
        end

        context 'giving all the tyre datas' do
          it 'should return only one tyre fee per garage' do
            FactoryGirl.create(:tyre_fee, garage: spanish_garage, price: 55, diameter_min: 10, diameter_max: 15 )
            FactoryGirl.create(:tyre_fee, garage: spanish_garage, price: 66, diameter_min: 16, diameter_max: 19 )
            api_get 'garages.json?rim=steel&vehicle=tourism&diameter=25', {}, @auth_token
            check_response(response)
            garage_tyre_fees = json(response.body).map { |garage| garage[:tyre_fees] }
            tyre_fees_ids = garage_tyre_fees.flatten.map { |tyre_fee| tyre_fee[:id] }
            expect(tyre_fees_ids.count).to be(1)
            expect(tyre_fees_ids.first).to be(spanish_fee.id)
          end
        end
      end

      def check_response(response)
        expect(response.status).to be(200)
        ids = json(response.body).map { |garage| garage[:id] }
        expect(ids.count).to be(1)
        expect(ids).to include(spanish_garage.id)
        expect(ids).not_to include(french_garage.id)
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
        expect(response.status).to be(200)
        ids = json(response.body).map { |g| g[:id] }
        expect(ids.count).to be(1)
        expect(ids).to include(garage_inside_radius.id)
        expect(ids).not_to include(garage_outside_radius.id)
      end

      it 'should return one garage searching by zip' do
        api_get 'garages.json?country=Italy&city=10139&radius=20', {}, @auth_token
        expect(response.status).to be(200)
        ids = json(response.body).map { |g| g[:id] }
        expect(ids.count).to be(1)
        expect(ids).to include(garage_inside_radius.id)
        expect(ids).not_to include(garage_outside_radius.id)
      end
    end
  end
end
