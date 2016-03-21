require 'spec_helper'

RSpec.describe "GarageRecruitables", type: :request do
  describe "#show" do
    shared_examples_for "an authorized show" do
      it "returning status 200 rendering garage_recruitable show" do
        recruitable = FactoryGirl.create(:garage_recruitable)
        get garage_recruitable_path(recruitable.id)
        expect(response.status).to be(200)
      end
    end

    shared_examples_for "an unauthorized show" do
      it 'returning status 302 rendering garage_recruitable show' do
        recruitable = FactoryGirl.create(:garage_recruitable)
        get garage_recruitable_path(recruitable.id)
        expect(response.status).to be(302)
      end
    end

    context "with an admin" do
      login_admin
      it_behaves_like "an authorized show"
    end

    context 'with a country manager' do
      login_country_manager
      it_behaves_like "an authorized show"
    end

    context 'with a garage owner' do
      login_owner
      it_behaves_like "an unauthorized show"
    end

    context 'with an api user' do
      login_api_user
      it_behaves_like "an authorized show"
    end
  end

  describe "#index" do
    shared_examples_for "an authorized index" do
      it "returning status 200 rendering garage_recruitable show" do
        get garage_recruitables_path
        expect(response.status).to be(200)
      end
    end

    shared_examples_for "an unauthorized index" do
      it 'should return status 302 rendering garage index' do
        get garage_recruitables_path
        expect(response.status).to be(302)
      end
    end

    context "with an admin" do
      login_admin
      it_behaves_like "an authorized index"
    end

    context 'with a country manager' do
      login_country_manager
      it_behaves_like "an authorized index"
    end

    context 'with a garage owner' do
      login_owner
      it_behaves_like "an unauthorized index"
    end

    context 'with an api user' do
      login_api_user
      it_behaves_like "an unauthorized index"
    end
  end
end
