describe 'Services' do
  api_user_token

  describe 'index' do
    let(:categorized_services_with_definitions) { FactoryGirl.create_list(:assigned_definition, 2) }

    context 'with a valid token' do
      context 'returning a valid json' do
        it 'has status 200' do
          api_get 'services.json', {}, @auth_token
          expect(response.status).to be(200)
          expect(response.body).not_to be_empty
          expect(response.content_type).to eq(Mime::JSON)
        end

        it 'contains a list of categories' do
          first_definition = categorized_services_with_definitions.first
          first_service_name = first_definition.service.name
          first_category_name = first_definition.service.service_category.name

          api_get 'services.json', {}, @auth_token
          ids = json(response.body).map { |service_category| service_category[:id] }
          first_category_response = json(response.body).first[:service_category]
          first_service_response = first_category_response[:services].first
          first_definition_response = first_service_response[:service_definitions].first

          expect(ids.count).to be(2)
          expect(first_category_response[:name]).to eq(first_category_name)
          expect(first_service_response[:name]).to eq(first_service_name)
          expect(first_definition_response).to eq(first_definition.name)
        end

        it 'contains the category name' do
          definition = categorized_services_with_definitions.first
          category_name = definition.service.service_category.name

          api_get 'services.json', {}, @auth_token
          category_response = json(response.body).first[:service_category]
          expect(category_response[:name]).to eq(category_name)
        end

        it 'contains the service name' do
          definition = categorized_services_with_definitions.first
          service_name = definition.service.name

          api_get 'services.json', {}, @auth_token
          service_response = json(response.body).first[:service_category][:services].first
          expect(service_response[:name]).to eq(service_name)
        end

        it 'contains the definition name' do
          definition = categorized_services_with_definitions.first

          api_get 'services.json', {}, @auth_token
          service_response = json(response.body).first[:service_category][:services].first
          definition_response = service_response[:service_definitions].first

          expect(definition_response).to eq(definition.name)
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
        api_get 'services.json', {}, 'Authorization' => 'Token token=wrongtoken'
        expect(response.status).to be(401)
      end
    end
  end
end
