describe 'GarageRegistrations' do
  api_user_token

  describe 'create' do

    context "with an invalid token" do
      it 'should return status 401' do
        post api_v1_garage_registrations_url, {format: :json }, 'Authorization' => 'Token token=wrongtoken'
        expect(response.status).to be(401)
      end
    end

    context "with a valid token" do
      it 'should return status 200' do
        post api_v1_garage_registrations_url, {format: :json }, @auth_token
        check_authorization(response)
      end
    end

    describe 'JSON response' do
      let(:garage_registration_params) { FactoryGirl.attributes_for(:garage_registration) }

      context "with a valid input" do
        it 'should contain the garage id ' do
          post api_v1_garage_registrations_url, garage_registration_params.merge(format: :json), @auth_token
          expect(garage_id(response)).to_not be_nil
          expect(errors(response)).to be_nil
        end
      end

      context "with an invalid input" do
        it 'should return validation errors' do
          garage_registration_params[garage_registration_params.keys.sample] = nil
          post api_v1_garage_registrations_url, garage_registration_params.merge(format: :json), @auth_token
          expect(garage_id(response)).to be_nil
          expect(errors(response)).to_not be_nil
        end
      end
    end

  describe 'update' do
    let(:garage) { FactoryGirl.create(:garage) }
    let(:services) { FactoryGirl.create_list(:service, 5) }

    context "with a valid token" do
      it 'should return status 200' do
        posted_params = { id: garage.id, service_ids: services.map(&:id) }
        patch api_v1_garage_registration_url(garage.id, format: :json), posted_params, @auth_token
        check_authorization(response)
      end
    end

    describe 'JSON response' do
      it 'should contain the garage id' do
        posted_params = { id: garage.id, service_ids: services.map(&:id) }
        patch api_v1_garage_registration_url(garage.id, format: :json), posted_params, @auth_token
        expect(garage_id(response)).to_not be_nil
      end
    end

    it 'should assign to the garage all the services sent' do
      posted_params = { id: garage.id, service_ids: services.map(&:id) }
      patch api_v1_garage_registration_url(garage.id, format: :json), posted_params, @auth_token
      garage.reload
      expect(garage.services.map(&:id)).to eq(Service.all.pluck(:id))
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
end
