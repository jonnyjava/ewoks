require 'spec_helper'

describe ServiceCategoriesController do
  login_admin
  let(:valid_attributes) { FactoryGirl.attributes_for(:service_category) }
  let(:invalid_attributes) { { 'wrong_param' => 'wrong' } }

  describe "GET #index" do
    it "assigns all service_categories as @service_categories" do
      service_category = ServiceCategory.create! valid_attributes
      get :index, {}
      expect(assigns(:service_categories)).to eq([service_category])
    end
  end
end
