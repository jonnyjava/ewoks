require 'spec_helper'

describe 'QuoteProposals' do
  api_user_token

  describe 'show' do
    let(:quote) { FactoryGirl.create(:quote_proposal).decorate }

    context "with an invalid authorization_token" do
      it 'should return status 401' do
        get api_v1_quote_proposal_url(quote.mail_token, format: :json), {}, 'Authorization' => 'Token token=wrongtoken'
        expect(response.status).to be(401)
      end
    end

    context "with a valid authorization_token" do
      context 'with an existing mail_token' do
        it 'should return status 200' do
          get api_v1_quote_proposal_url(quote.mail_token, format: :json), {}, @auth_token
          expect(response.status).to be(200)
          expect(response.body).not_to be_blank
          expect(response.content_type).to eq(Mime::JSON)
        end

        it 'should return a json containing the quote info: proposal, price, expiration and doc names' do
          get api_v1_quote_proposal_url(quote.mail_token, format: :json), {}, @auth_token
          response_quote = json(response.body)[:quote]
          expect(response_quote[:proposal]).to eq(quote.proposal)
          expect(response_quote[:price]).to eq(quote.price)
          expect(Date.parse(response_quote[:expiration])).to eq(quote.expiration)
          expect(response_quote[:docs][:doc1][:file_name]).to eq(quote.doc1_file_name)
          expect(response_quote[:docs][:doc1][:file_url]).to eq(quote.doc1.url)
          expect(response_quote[:docs][:doc2][:file_name]).to eq(quote.doc2_file_name)
          expect(response_quote[:docs][:doc2][:file_url]).to eq(quote.doc2.url)
          expect(response_quote[:docs][:doc3][:file_name]).to eq(quote.doc3_file_name)
          expect(response_quote[:docs][:doc3][:file_url]).to eq(quote.doc3.url)
        end

        it 'should return a json containing the deamand info: city, name_and_surnames, phone, email, service, car, vin_number, details ans user_comments' do
          get api_v1_quote_proposal_url(quote.mail_token, format: :json), {}, @auth_token
          response_demand = json(response.body)[:demand]
          demand = quote.demand.decorate
          expect(response_demand[:city]).to eq(demand.city)
          expect(response_demand[:name_and_surnames]).to eq(demand.name_and_surnames)
          expect(response_demand[:phone]).to eq(demand.phone)
          expect(response_demand[:email]).to eq(demand.email)
          expect(response_demand[:service]).to eq(demand.service_with_category)
          expect(response_demand[:car]).to eq(demand.car_complete_info)
          expect(response_demand[:vin_number]).to eq(demand.vin_number)
          expect(response_demand[:details]).to eq(demand.demand_details)
          expect(response_demand[:user_comments]).to eq(demand.comments)
        end
      end

      context 'with a not existing mail_token' do
        it 'should return status 422' do
          get api_v1_quote_proposal_url('Chewbacca', format: :json), {}, @auth_token
          expect(response.status).to be(422)
          expect(response.body).to be_blank
        end
      end
    end
  end

  describe 'update' do
    let(:quote) { FactoryGirl.create(:quote_proposal) }

    context "with an invalid authorization_token" do
      it 'should return status 401' do
        patch api_v1_quote_proposal_url(quote.mail_token, format: :json), {}, 'Authorization' => 'Token token=wrongtoken'
        expect(response.status).to be(401)
      end
    end

    context "with a valid authorization_token" do
      context 'with an existing mail_token' do
        context 'when the quote is accepted' do
          it 'should return status 200' do
            patch api_v1_quote_proposal_url(quote.mail_token, format: :json), {status: 'accepted'}, @auth_token
            quote.reload
            expect(response.status).to be(200)
            expect(quote.status).to eq('accepted')
          end

          it 'should respond with garage contact info' do
            garage = quote.garage
            patch api_v1_quote_proposal_url(quote.mail_token, format: :json), {status: 'accepted'}, @auth_token
            expect(json(response.body)[:name]).to eq(garage.name)
            expect(json(response.body)[:street]).to eq(garage.street)
            expect(json(response.body)[:zip]).to eq(garage.zip)
            expect(json(response.body)[:email]).to eq(garage.email)
            expect(json(response.body)[:phone]).to eq(garage.phone)
            expect(json(response.body)[:mobile]).to eq(garage.mobile)
            expect(json(response.body)[:website]).to eq(garage.website)
          end
        end

        it 'should return status 200 when the quote is refused' do
          patch api_v1_quote_proposal_url(quote.mail_token, format: :json), {status: 'refused'}, @auth_token
          quote.reload
          expect(response.status).to be(200)
          expect(json(response.body)).to be_blank
          expect(quote.status).to eq('refused')
        end

        it 'should return status 422 when the an invalid status is passed' do
          patch api_v1_quote_proposal_url(quote.mail_token, format: :json), {status: 'death_star'}, @auth_token
          quote.reload
          expect(response.status).to be(422)
          expect(response.body).to be_blank
          expect(quote.status).to_not eq('death_star')
        end
      end

      context 'with a not existing token' do
        it 'should return status 422' do
          patch api_v1_quote_proposal_url('Chewbacca', format: :json), {status: status}, @auth_token
          expect(response.status).to be(422)
          expect(response.body).to be_blank
        end
      end
    end
  end
end
