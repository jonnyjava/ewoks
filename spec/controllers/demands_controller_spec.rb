require "spec_helper"
describe DemandsController do
  login_admin
  let(:valid_attributes) { FactoryGirl.attributes_for(:demand) }
  let(:demand) { FactoryGirl.create(:demand) }
  let(:invalid_attributes) { { 'wrong_param' => 'wrong' } }
  let(:valid_session) { {} }

  describe "GET #index" do
    it "assigns all demands as @demands" do
      demand
      get :index, {}, valid_session
      expect(assigns(:demands)).to eq([demand])
    end
  end

  describe "GET #show" do
    it "assigns the requested demand as @demand" do
      demand
      get :show, {:id => demand.to_param}, valid_session
      expect(assigns(:demand)).to eq(demand)
    end
  end

  describe "GET #edit" do
    it "assigns the requested demand as @demand" do
      get :edit, {id: demand.to_param}, valid_session
      expect(assigns(:demand)).to eq(demand)
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      it "redirects to the demand" do
        put :update, {id: demand.to_param, demand: valid_attributes}, valid_session
        expect(response).to redirect_to(demand)
      end
    end

    context "with invalid params" do

      it "re-renders the 'edit' template" do
        put :update, {id: demand.to_param, demand: {"city"=>nil}}, valid_session
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested demand" do
      demand
      expect {
        delete :destroy, {id: demand.to_param}, valid_session
      }.to change(Demand, :count).by(-1)
    end

    it "redirects to the demands list" do
      demand
      delete :destroy, {id: demand.to_param}, valid_session
      expect(response).to redirect_to(demands_url)
    end
  end
end
