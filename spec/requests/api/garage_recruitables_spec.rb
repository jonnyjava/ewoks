require 'spec_helper'

describe 'GarageRecruitables' do
  before(:each) do
    user = FactoryGirl.create(:api_user)
    @auth_token = { 'Authorization' => token_header(user.auth_token) }
  end

  def token_header(token)
    ActionController::HttpAuthentication::Token.encode_credentials(token)
  end

  describe 'show' do
    let(:recruitable) { FactoryGirl.create(:garage_recruitable) }

    context "with an invalid token" do
      it 'should return status 401' do
        get api_v1_garage_recruitable_url(recruitable.token, format: :json), {}, 'Authorization' => 'Token token=wrongtoken'
        expect(response.status).to be(401)
      end
    end

    context "with a valid authorization_token" do
      context 'with an existing token' do
        it 'should return status 200' do
          get api_v1_garage_recruitable_url(recruitable.token, format: :json), {}, @auth_token
          check_authorization(response)
        end
      end

      context 'with a not existing token' do
        it 'should return status 422' do
          get api_v1_garage_recruitable_url('Chewbacca', format: :json), {}, @auth_token
          expect(response.status).to be(422)
        end
      end
    end
  end

  def check_authorization(response)
    expect(response.status).to be(200)
    expect(response.body).not_to be_empty
    expect(response.content_type).to eq(Mime::JSON)
  end

  private
    def garage_id(response)
      json(response.body)[:id]
    end

    def errors(response)
      json(response.body)[:errors]
    end
end
