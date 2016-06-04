require 'spec_helper'

describe ServiceDefinitionsController do
  login_admin
  let(:service_definition) { FactoryGirl.create(:service_definition) }
  let(:valid_attributes) { FactoryGirl.attributes_for(:service_definition) }
  let(:invalid_attributes) { { 'wrong_param' => 'wrong' } }
  let(:valid_session) { {} }


  describe 'GET #index' do
    it 'assigns all service_definitions as @service_definitions' do
      get :index, {}, valid_session
      expect(assigns(:service_definitions)).to eq([service_definition])
    end
  end

  describe 'GET #new' do
    it 'assigns a new service_definition as @service_definition' do
      get :new, {}, valid_session
      expect(assigns(:service_definition)).to be_a_new(ServiceDefinition)
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new ServiceDefinition' do
        expect {
          post :create, {service_definition: valid_attributes }, valid_session
        }.to change(ServiceDefinition, :count).by(1)
      end

      it 'assigns a newly created service_definition as @service_definition' do
        post :create, {service_definition: valid_attributes }, valid_session
        expect(assigns(:service_definition)).to be_a(ServiceDefinition)
        expect(assigns(:service_definition)).to be_persisted
      end

      it 'redirects to the created service_definition' do
        post :create, {service_definition: valid_attributes }, valid_session
        expect(response).to redirect_to(service_definitions_url)
      end
    end

    context 'with invalid params' do
      it 'assigns a newly created but unsaved service_definition as @service_definition' do
        post :create, {service_definition: invalid_attributes }, valid_session
        expect(assigns(:service_definition)).to be_a_new(ServiceDefinition)
      end

      it 're-renders the new template' do
        post :create, {service_definition: invalid_attributes }, valid_session
        expect(response).to render_template('new')
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      it 'assigns the requested service_definition as @service_definition' do
        put :update, { id: service_definition.to_param, service_definition: valid_attributes }, valid_session
        expect(assigns(:service_definition)).to eq(service_definition)
      end

      it 'redirects to the service_definition' do
        put :update, { id: service_definition.to_param, service_definition: valid_attributes }, valid_session
        expect(response).to redirect_to(service_definitions_url)
      end
    end

    context 'breaking the association with service' do
      it 'should set the service_id to nil' do
        put :update, { id: service_definition.to_param, service_definition: { service_id: nil } }, valid_session
        service_definition.reload
        expect(service_definition.service_id).to be_nil
      end
    end

    context 'with invalid params' do
      it 'assigns the service_definition as @service_definition' do
        put :update, { id: service_definition.to_param, service_definition: invalid_attributes }, valid_session
        expect(assigns(:service_definition)).to eq(service_definition)
      end

      it 're-renders the edit template' do
        put :update, { id: service_definition.to_param, service_definition: { name: nil } }, valid_session
        expect(response).to render_template('new')
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested service_definition' do
      service_definition
      expect {
        delete :destroy, { id: service_definition.to_param}, valid_session
      }.to change(ServiceDefinition, :count).by(-1)
    end

    it 'redirects to the service_definitions list' do
      delete :destroy, { id: service_definition.to_param}, valid_session
      expect(response).to redirect_to(service_definitions_url)
    end
  end
end
