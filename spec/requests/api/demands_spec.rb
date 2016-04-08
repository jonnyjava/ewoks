require 'spec_helper'

describe 'DemandRegistrations' do
  api_user_token

  describe 'create' do
    let(:demand_params) { { demand: FactoryGirl.attributes_for(:demand).merge(format: :json) } }

    context 'with an invalid token' do
      it 'should return status 401' do
        post api_v1_demands_url, demand_params, 'Authorization' => 'Token token=wrongtoken'
        expect(response.status).to be(401)
      end
    end

    context "with a valid token" do
      it 'should return status 200' do
        post api_v1_demands_url, demand_params, @auth_token
        expect(response.status).to be(200)
      end
    end

    describe 'JSON response' do
      context 'with a valid input' do
        it 'should create a new demand' do
          demands_count = Demand.count
          post api_v1_demands_url, demand_params, @auth_token
          expect(Demand.count).to eq(demands_count + 1)
          expect(response.body).to be_blank
        end
      end
      context 'with an invalid input' do
        it 'should return validation errors' do
          demand_params[:demand][:city] = nil
          demand_params[:demand][:name_and_surnames] = nil
          demand_params[:demand][:phone] = nil
          demand_params[:demand][:email] = nil
          post api_v1_demands_url, demand_params, @auth_token

          expect(errors(response)).to_not be_nil
          expect(errors(response)[:city]).to_not be_nil
          expect(errors(response)[:name_and_surnames]).to_not be_nil
          expect(errors(response)[:phone]).to_not be_nil
          expect(errors(response)[:email]).to_not be_nil
        end
      end
    end

  private

    def errors(response)
      json(response.body)[:errors]
    end
  end
end
