require 'spec_helper'

describe 'GarageRecruitables' do
  api_user_token

  describe 'show' do
    let(:recruitable) { FactoryGirl.create(:garage_recruitable, status: 'recruitable') }

    context "with an invalid authorization_token" do
      it 'should return status 401' do
        get api_v1_garage_recruitable_url(recruitable.token, format: :json), {}, 'Authorization' => 'Token token=wrongtoken'
        expect(response.status).to be(401)
      end
    end

    context "with a valid authorization_token" do
      context 'with an existing recruitable_token' do
        context 'with a recruitable status' do
          it 'should return status 200' do
            get api_v1_garage_recruitable_url(recruitable.token, format: :json), {}, @auth_token
            expect(response.status).to be(200)
            expect(response.body).not_to be_blank
            expect(response.content_type).to eq(Mime::JSON)
          end

          it 'should return a json containing at least the garage_name and the token' do
            get api_v1_garage_recruitable_url(recruitable.token, format: :json), {}, @auth_token
            expect(json(response.body)[:garage_name]).to eq(recruitable.name)
            expect(json(response.body)[:token]).to eq(recruitable.token)
          end
        end

        context 'with a recruited status' do
            let(:not_recruitable) { FactoryGirl.create(:garage_recruitable, status: 'recruited') }
          it 'should return status 200' do
            get api_v1_garage_recruitable_url(not_recruitable.token, format: :json), {}, @auth_token
            expect(response.status).to be(200)
            expect(response.body).not_to be_blank
          end

          it 'should return a json containing the "already registered" message' do
            get api_v1_garage_recruitable_url(not_recruitable.token, format: :json), {}, @auth_token
            expect(response.content_type).to eq(Mime::JSON)
            expect(json(response.body)[:message]).to eq(I18n.translate('already_registered'))
          end
        end
      end

      context 'with a not existing recruitable_token' do
        it 'should return status 422' do
          get api_v1_garage_recruitable_url('Chewbacca', format: :json), {}, @auth_token
          expect(response.status).to be(422)
          expect(response.body).to be_blank
        end
      end
    end
  end

  describe 'update' do
    let(:recruitable) { FactoryGirl.create(:garage_recruitable) }

    context "with an invalid authorization_token" do
      it 'should return status 401' do
        patch api_v1_garage_recruitable_url(recruitable.token, format: :json), {}, 'Authorization' => 'Token token=wrongtoken'
        expect(response.status).to be(401)
      end
    end

    context "with a valid authorization_token" do
      context 'with an existing recruitable_token' do
        it 'should return status 200' do
          token = recruitable.token
          status = "recruited"
          patch api_v1_garage_recruitable_url(token, format: :json), {status: status}, @auth_token

          expect(GarageRecruitable.find_by_token(token).status).to eq(status)
          expect(response.status).to be(200)
          expect(response.body).to be_blank
        end
      end

      context 'with a not existing recruitable_token' do
        it 'should return status 422' do
          patch api_v1_garage_recruitable_url('Chewbacca', format: :json), {status: status}, @auth_token
          expect(response.status).to be(422)
          expect(response.body).to be_blank
        end
      end
    end
  end
end
