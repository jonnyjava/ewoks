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
  # This should return the minimal set of attributes required to create a valid
  # TyreFee. As you add validations to TyreFee, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) { { "price" => Faker::Number.number(2) } }
  let(:invalid_attributes) { { "wrong_param" => "wrong" } }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # TyreFeesController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET index" do
    it "assigns all tyre_fees as @tyre_fees" do
      tyre_fee = TyreFee.create! valid_attributes
      get :index, {}, valid_session
      assigns(:tyre_fees).should eq([tyre_fee])
    end
  end

  describe "GET show" do
    it "assigns the requested tyre_fee as @tyre_fee" do
      tyre_fee = TyreFee.create! valid_attributes
      get :show, {:id => tyre_fee.to_param}, valid_session
      assigns(:tyre_fee).should eq(tyre_fee)
    end
  end

  describe "GET new" do
    it "assigns a new tyre_fee as @tyre_fee" do
      get :new, {}, valid_session
      assigns(:tyre_fee).should be_a_new(TyreFee)
    end
  end

  describe "GET edit" do
    it "assigns the requested tyre_fee as @tyre_fee" do
      tyre_fee = TyreFee.create! valid_attributes
      get :edit, {:id => tyre_fee.to_param}, valid_session
      assigns(:tyre_fee).should eq(tyre_fee)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new TyreFee" do
        expect {
          post :create, {:tyre_fee => valid_attributes}, valid_session
        }.to change(TyreFee, :count).by(1)
      end

      it "assigns a newly created tyre_fee as @tyre_fee" do
        post :create, {:tyre_fee => valid_attributes}, valid_session
        assigns(:tyre_fee).should be_a(TyreFee)
        assigns(:tyre_fee).should be_persisted
      end

      it "redirects to the created tyre_fee" do
        post :create, {:tyre_fee => valid_attributes}, valid_session
        response.should redirect_to(TyreFee.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved tyre_fee as @tyre_fee" do
        # Trigger the behavior that occurs when invalid params are submitted
        TyreFee.any_instance.stub(:save).and_return(false)
        post :create, {tyre_fee: invalid_attributes}, valid_session
        assigns(:tyre_fee).should be_a_new(TyreFee)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        TyreFee.any_instance.stub(:save).and_return(false)
        post :create, {tyre_fee: invalid_attributes}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested tyre_fee" do
        tyre_fee = TyreFee.create! valid_attributes
        # Assuming there are no other tyre_fees in the database, this
        # specifies that the TyreFee created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        TyreFee.any_instance.should_receive(:update).with( valid_attributes )
        put :update, {:id => tyre_fee.to_param, tyre_fee: valid_attributes }, valid_session
      end

      it "assigns the requested tyre_fee as @tyre_fee" do
        tyre_fee = TyreFee.create! valid_attributes
        put :update, {:id => tyre_fee.to_param, tyre_fee: valid_attributes}, valid_session
        assigns(:tyre_fee).should eq(tyre_fee)
      end

      it "redirects to the tyre_fee" do
        tyre_fee = TyreFee.create! valid_attributes
        put :update, {:id => tyre_fee.to_param, tyre_fee: valid_attributes}, valid_session
        response.should redirect_to(tyre_fee)
      end
    end

    describe "with invalid params" do
      it "assigns the tyre_fee as @tyre_fee" do
        tyre_fee = TyreFee.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        TyreFee.any_instance.stub(:save).and_return(false)
        put :update, {:id => tyre_fee.to_param, tyre_fee: invalid_attributes }, valid_session
        assigns(:tyre_fee).should eq(tyre_fee)
      end

      it "re-renders the 'edit' template" do
        tyre_fee = TyreFee.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        TyreFee.any_instance.stub(:save).and_return(false)
        put :update, {:id => tyre_fee.to_param, tyre_fee: invalid_attributes }, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested tyre_fee" do
      tyre_fee = TyreFee.create! valid_attributes
      expect {
        delete :destroy, {:id => tyre_fee.to_param}, valid_session
      }.to change(TyreFee, :count).by(-1)
    end

    it "redirects to the tyre_fees list" do
      tyre_fee = TyreFee.create! valid_attributes
      delete :destroy, {:id => tyre_fee.to_param}, valid_session
      response.should redirect_to(tyre_fees_url)
    end
  end

end
