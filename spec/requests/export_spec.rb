require 'spec_helper'

RSpec.describe "Recruitables::Export", type: :request do
  describe "#index" do
    shared_examples_for "an authorized page" do
      it "returning status 200 rendering Recruitable::Export index" do
        get recruitables_export_index_path(format: :xls)
        expect(response.status).to be(200)
      end
    end

    shared_examples_for "an unauthorized page" do
      it 'returning status 302 rendering Recruitable::Export index' do
        get recruitables_export_index_path(format: :xls)
        expect(response.status).to be(302)
      end
    end

    context "with an admin" do
      login_admin
      it_behaves_like "an authorized page"
    end

    context 'with a country manager' do
      login_country_manager
      it_behaves_like "an authorized page"
    end

    context 'with a garage owner' do
      login_owner
      it_behaves_like "an unauthorized page"
    end

    context 'with an api user' do
      login_api_user
      it_behaves_like "an unauthorized page"
    end
  end
end
