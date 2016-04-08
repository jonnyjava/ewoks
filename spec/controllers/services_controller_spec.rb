require "spec_helper"
describe ServicesController do
  login_admin
  let(:valid_attributes) { FactoryGirl.attributes_for(:service) }
  let(:invalid_attributes) { { 'wrong_param' => 'wrong' } }
  let(:valid_session) { {} }

  describe "GET #index" do
    it "assigns all services as @services" do
      service = Service.create! valid_attributes
      get :index, {}, valid_session
      expect(assigns(:services)).to eq([service])
    end
  end
end
