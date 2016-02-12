require 'spec_helper'

describe 'GarageRegistrations' do

  def token_header(token)
    ActionController::HttpAuthentication::Token.encode_credentials(token)
  end

  describe 'create' do
    before(:each) do
      user = FactoryGirl.create(:api_user)
      @auth_token = { 'Authorization' => token_header(user.auth_token) }
    end

    context "with an invalid token" do
      it 'should return status 401' do
        post api_v1_garage_registrations_url, {format: :json }, 'Authorization' => 'Token token=wrongtoken'
        expect(response.status).to be(401)
      end
    end

    context "with a valid token" do
      it 'should return status 200' do
        post api_v1_garage_registrations_url, {format: :json }, @auth_token
        expect(response.status).to be(200)
        expect(response.body).not_to be_empty
        expect(response.content_type).to eq(Mime::JSON)
      end
    end

    describe 'JSON response' do
      let(:garage_registration_params) { FactoryGirl.attributes_for(:garage_registration).merge(format: :json) }

      context "with a valid input" do
        it 'should contain the garage id ' do
          post api_v1_garage_registrations_url, garage_registration_params, @auth_token
          expect(garage_id(response)).to_not be_nil
          expect(errors(response)).to be_nil
        end
      end

      context "with an invalid input" do
        it 'should return validation errors' do
          garage_registration_params[garage_registration_params.keys.sample] = nil
          post api_v1_garage_registrations_url, garage_registration_params, @auth_token
          expect(garage_id(response)).to be_nil
          expect(errors(response)).to_not be_nil
        end
      end
    end

  private
    def garage_id(response)
      json(response.body)[:id]
    end

    def errors(response)
      json(response.body)[:errors]
    end
  end
end
