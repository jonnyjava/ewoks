require 'spec_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

describe TyreFeesController do
  login_user

  let(:valid_attributes) { { "vehicle_type" => 1, "fee" => fee } }
  let(:invalid_attributes) { { "wrong_param" => "wrong" } }
  let(:fee_params) { { name: fee.name, price: fee.price } }
  let(:garage_params) { { garage_id: garage, tyre_fee: valid_attributes, fee: fee_params } }
  let(:valid_session) { {} }

  let(:garage) { FactoryGirl.create(:garage) }
  let(:fee) { FactoryGirl.create(:fee, garage: garage) }
  let!(:tyre_fee) { FactoryGirl.create(:tyre_fee, fee: fee, "vehicle_type" => 1) }

  describe "GET index" do
    let(:garage2) { FactoryGirl.create(:garage) }
    let(:fee2) { FactoryGirl.create(:fee, garage: garage2) }
    let!(:tyre_fee2) { FactoryGirl.create(:tyre_fee, fee: fee2) }
    it "should show only the tyre fees of a given garage" do
      get :index, {garage_id: garage}, valid_session
      assigns(:tyre_fees).count.should eq(1)
      assigns(:tyre_fees).first.should eq(tyre_fee)
    end
  end

  describe "GET show" do
    it "assigns the requested tyre_fee as @tyre_fee" do
      get :show, {garage_id: garage, id: tyre_fee.to_param}, valid_session
      assigns(:tyre_fee).should eq(tyre_fee)
    end
  end

  describe "GET new" do
    it "assigns a new tyre_fee as @tyre_fee" do
      get :new, {garage_id: garage}, valid_session
      assigns(:tyre_fee).should be_a_new(TyreFee)
    end
  end

  describe "GET edit" do
    it "assigns the requested tyre_fee as @tyre_fee" do
      get :edit, {garage_id: garage, id: tyre_fee.to_param}, valid_session
      assigns(:tyre_fee).should eq(tyre_fee)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new TyreFee" do
        expect {
          post :create, garage_params, valid_session
        }.to change(TyreFee, :count).by(1)
      end

      it "assigns a newly created tyre_fee as @tyre_fee" do
        post :create, {garage_id: garage, tyre_fee: valid_attributes, fee: fee_params }, valid_session
        assigns(:tyre_fee).should be_a(TyreFee)
        assigns(:tyre_fee).should be_persisted
      end

      it "redirects to the created tyre_fee" do
        post :create, {garage_id: garage, tyre_fee: valid_attributes, fee: fee_params }, valid_session
        response.should redirect_to garage_tyre_fee_url(garage, TyreFee.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved tyre_fee as @tyre_fee" do
        # Trigger the behavior that occurs when invalid params are submitted
        TyreFee.any_instance.stub(:save).and_return(false)
        post :create, {garage_id: garage, tyre_fee: invalid_attributes, fee: fee_params }, valid_session
        assigns(:tyre_fee).should be_a_new(TyreFee)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        TyreFee.any_instance.stub(:save).and_return(false)
        post :create, {garage_id: garage, tyre_fee: invalid_attributes, fee: fee_params }, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested tyre_fee" do
        TyreFee.any_instance.should_receive(:update).with( "vehicle_type" => "1" )
        put :update, {garage_id: garage, id: tyre_fee.to_param, tyre_fee: valid_attributes, fee: fee_params }, valid_session
      end

      it "assigns the requested tyre_fee as @tyre_fee" do
        put :update, {garage_id: garage, id: tyre_fee.to_param, tyre_fee: valid_attributes, fee: fee_params}, valid_session
        assigns(:tyre_fee).should eq(tyre_fee)
      end

      it "redirects to the tyre_fee" do
        put :update, {garage_id: garage, id: tyre_fee.to_param, tyre_fee: valid_attributes, fee: fee_params}, valid_session
        response.should redirect_to garage_tyre_fee_url(garage, tyre_fee)
      end
    end

    describe "with invalid params" do
      it "assigns the tyre_fee as @tyre_fee" do
        # Trigger the behavior that occurs when invalid params are submitted
        TyreFee.any_instance.stub(:save).and_return(false)
        put :update, {garage_id: garage, id: tyre_fee.to_param, tyre_fee: invalid_attributes, fee: fee_params }, valid_session
        assigns(:tyre_fee).should eq(tyre_fee)
      end

      it "re-renders the 'edit' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        TyreFee.any_instance.stub(:save).and_return(false)
        put :update, {garage_id: garage, id: tyre_fee.to_param, tyre_fee: invalid_attributes, fee: fee_params }, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested tyre_fee" do
      expect {
        delete :destroy, {garage_id: garage, id: tyre_fee.to_param}, valid_session
      }.to change(TyreFee, :count).by(-1)
    end

    it "redirects to the tyre_fees list" do
      delete :destroy, {garage_id: garage, id: tyre_fee.to_param}, valid_session
      response.should redirect_to garage_tyre_fees_url(garage)
    end
  end

end
