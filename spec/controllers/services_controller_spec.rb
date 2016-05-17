require 'spec_helper'
describe ServicesController do
  login_admin
  let(:valid_attributes) { FactoryGirl.attributes_for(:service) }
  let(:invalid_attributes) { { 'wrong_param' => 'wrong' } }
  let(:valid_session) { {} }

  describe 'GET #index' do
    it 'assigns all services as @services' do
      service = Service.create! valid_attributes
      get :index, {}, valid_session
      expect(assigns(:services)).to eq([service])
    end
  end

  describe 'PUT #update' do
    let!(:service) { FactoryGirl.create(:service) }
    context 'with valid params' do
      it 'assigns the requested service as @service' do
        put :update, {id: service.to_param, service: valid_attributes}, valid_session
        expect(assigns(:service)).to eq(service)
      end

      it 'redirects to the service' do
        put :update, {id: service.to_param, service: valid_attributes}, valid_session
        expect(response).to redirect_to(service_categories_url)
      end
    end

    context 'with invalid params' do
      it 'assigns the service as @service' do
        put :update, {id: service.to_param, service: invalid_attributes}, valid_session
        expect(assigns(:service)).to eq(service)
      end

      it 're-renders the index template' do
        put :update, {id: service.to_param, service: {name: nil} }, valid_session
        expect(response).to render_template('index')
      end
    end
  end
end
