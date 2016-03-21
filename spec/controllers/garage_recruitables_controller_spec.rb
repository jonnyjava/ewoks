require 'spec_helper'

describe GarageRecruitablesController do
  login_admin

  let(:valid_attributes) { FactoryGirl.attributes_for(:garage_recruitable) }
  let(:invalid_attributes) { { 'wrong_param' => 'wrong', tax_id: nil } }

  let(:valid_session) { {} }

  describe "#index" do
    it "should render the index page" do
      garage_recruitable = GarageRecruitable.create! valid_attributes
      get :index, {}, valid_session
      expect(response).to render_template(:index)
    end
  end

  describe "#show" do
    it "should render the show page" do
      garage_recruitable = GarageRecruitable.create! valid_attributes
      get :show, {id: garage_recruitable.to_param}, valid_session
      expect(response).to render_template(:show)
    end
  end

  describe "#edit" do
    it "should render the edit page" do
      garage_recruitable = GarageRecruitable.create! valid_attributes
      get :edit, {id: garage_recruitable.to_param}, valid_session
      expect(response).to render_template(:edit)
    end
  end

  describe "#create" do
    context "with valid params" do
      it "should create a new GarageRecruitable" do
        expect {
          post :create, {garage_recruitable: valid_attributes}, valid_session
        }.to change(GarageRecruitable, :count).by(1)
      end

      it "should redirect to show" do
        post :create, {:garage_recruitable => valid_attributes}, valid_session
        expect(response).to redirect_to(GarageRecruitable.last)
      end

      it "should redirect to the created GarageRecruitable" do
        post :create, {:garage_recruitable => valid_attributes}, valid_session
        expect(response).to redirect_to(GarageRecruitable.last)
      end
    end

    context "with invalid params" do
      it "should not create a new GarageRecruitable" do
        recruitables = GarageRecruitable.count
        post :create, {:garage_recruitable => invalid_attributes}, valid_session
        expect(GarageRecruitable.count).to eq(recruitables)
      end

      it "should re-render the 'new' template" do
        post :create, {:garage_recruitable => invalid_attributes}, valid_session
        expect(response).to render_template(:new)
      end
    end
  end

  describe "#update" do
    context "with valid params" do
      let(:new_attributes) { FactoryGirl.attributes_for(:garage_recruitable) }

      it "updates the requested garage_recruitable" do
        garage_recruitable = GarageRecruitable.create! valid_attributes
        name = garage_recruitable.name
        put :update, {id: garage_recruitable.to_param, garage_recruitable: new_attributes}, valid_session
        garage_recruitable.reload
        expect(garage_recruitable.name).to eq(new_attributes[:name])
        expect(garage_recruitable.name).to_not eq(name)
      end

      it "redirects to the garage_recruitable" do
        garage_recruitable = GarageRecruitable.create! valid_attributes
        put :update, {id: garage_recruitable.to_param, garage_recruitable: valid_attributes}, valid_session
        expect(response).to redirect_to(garage_recruitable)
      end
    end

    context "with invalid params" do
      it "should re-render the 'edit' template" do
        garage_recruitable = GarageRecruitable.create! valid_attributes
        put :update, {id: garage_recruitable.to_param, garage_recruitable: invalid_attributes}, valid_session
        expect(response).to render_template(:edit)
      end
    end
  end

  describe "#destroy" do
    it "destroys the requested garage_recruitable" do
      garage_recruitable = GarageRecruitable.create! valid_attributes
      expect {
        delete :destroy, {id: garage_recruitable.to_param}, valid_session
      }.to change(GarageRecruitable, :count).by(-1)
    end

    it "redirects to the garage_recruitables list" do
      garage_recruitable = GarageRecruitable.create! valid_attributes
      delete :destroy, {id: garage_recruitable.to_param}, valid_session
      expect(response).to redirect_to(garage_recruitables_url)
    end
  end
end
