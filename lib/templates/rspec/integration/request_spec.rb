require 'spec_helper'

describe "<%= class_name.pluralize %>" do
  describe "#index" do
    shared_examples_for "someone authorized" do
      it "returning status 200" do
        FactoryGirl.create(:<%= file_name %>)
        get <%= index_helper %>_path
        expect(response.status).to be(200)
      end
    end

    shared_examples_for "someone unauthorized" do
      it "returning status 302" do
        FactoryGirl.create(:<%= file_name %>)
        get <%= index_helper %>_path
        expect(response.status).to be(302)
      end
    end

    context 'with an admin' do
      login_admin
      it_behaves_like "someone authorized"
    end

    context 'with a country manager' do
      login_country_manager
      it_behaves_like "someone unauthorized"
    end

    context 'with an owner' do
      login_owner
      it_behaves_like 'someone unauthorized'
    end

    context 'with an api user' do
      login_api_user
      it_behaves_like 'someone unauthorized'
    end
  end
end
