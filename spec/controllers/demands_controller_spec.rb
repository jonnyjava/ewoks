require "spec_helper"
describe DemandsController do
  login_admin
  let(:valid_attributes) { FactoryGirl.attributes_for(:demand) }
  let(:invalid_attributes) { { 'wrong_param' => 'wrong' } }
  let(:valid_session) { {} }

  describe "GET #index" do
    it "assigns all demands as @demands" do
      demand = Demand.create! valid_attributes
      get :index, {}, valid_session
      expect(assigns(:demands)).to eq([demand])
    end
  end

  describe "GET #show" do
    it "assigns the requested demand as @demand" do
      demand = Demand.create! valid_attributes
      get :show, {:id => demand.to_param}, valid_session
      expect(assigns(:demand)).to eq(demand)
    end
  end
end
