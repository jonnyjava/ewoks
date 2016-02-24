require 'spec_helper'
require "set"


describe "Garages" do
  describe "#index" do
    shared_examples_for "an index" do
      it "returning status 200 rendering garage index" do
        get garages_path
        expect(response.status).to be(200)
      end

      it "returning status 200 calling toggle status" do
        garage = FactoryGirl.create(:garage)
        expect(response.status).to be(200)
      end
    end
    context 'with an admin' do
      login_admin
      it_behaves_like "an index"

    end

    context 'with a country manager' do
      login_country_manager
      it_behaves_like "an index"
    end

    context 'with an api user' do
      login_api_user
      it 'should return status 302 rendering garage index' do
        garage = FactoryGirl.create(:spanish_garage)
        get garage_path(garage.id)
        expect(response.status).to be(302)
      end
    end
  end

  describe "#show" do
    shared_examples_for "a show" do
      it "returning status 200 rendering garage show" do
        garage = FactoryGirl.create(:spanish_garage)
        get garage_path(garage.id)
        expect(response.status).to be(200)
      end
    end

    context 'with an admin' do
      login_admin
      it_behaves_like "a show"
    end

    context 'with a country manager' do
      login_country_manager
      it_behaves_like "a show"
    end

    context 'with an owner' do
      it "should return status 200 rendering garage show" do
        user = FactoryGirl.create(:owner)
        garage = FactoryGirl.create(:garage, user: user)
        post_via_redirect user_session_path, 'user[email]' => user.email, 'user[password]' => user.password
        get garage_path(garage.id)
        expect(response.status).to be(200)
      end
    end

    context 'with an api user' do
      login_api_user
      it 'should return status 302 rendering garage show' do
        garage = FactoryGirl.create(:spanish_garage)
        get garage_path(garage.id)
        expect(response.status).to be(302)
      end
    end
  end
end
