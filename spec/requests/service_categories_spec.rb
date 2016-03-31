require 'spec_helper'

describe "ServiceCategories", type: :request do
  describe "#index" do
    before(:each) do
      FactoryGirl.create(:service_category)
    end

    shared_examples_for "an authorized page" do
      it "returning status 200" do
        get service_categories_path
        expect(response.status).to be(200)
      end
    end

    shared_examples_for "an unauthorized page" do
      it "returning status 302" do
        get service_categories_path
        expect(response.status).to be(302)
      end
    end

    context 'with an admin' do
      login_admin
      it_behaves_like "an authorized page"
    end

    context 'with a country manager' do
      login_country_manager
      it_behaves_like "an unauthorized page"
    end

    context 'with an owner' do
      login_owner
      it_behaves_like 'an unauthorized page'
    end

    context 'with an api user' do
      login_api_user
      it_behaves_like 'an unauthorized page'
    end
  end

  describe "#show" do
    login_admin
    it 'should route to a 404' do
      service_category = FactoryGirl.create(:service_category)
      get service_categories_path(service_category)
      expect(response.status).to be(404)
    end
  end
end
