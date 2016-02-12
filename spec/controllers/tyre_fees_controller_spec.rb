require 'spec_helper'
describe TyreFeesController do
  login_user

  let(:valid_attributes) { FactoryGirl.attributes_for(:tyre_fee) }
  let(:invalid_attributes) { { 'wrong_param' => 'wrong' } }
  let(:garage_params) { { garage_id: garage, tyre_fee: valid_attributes } }
  let(:garage) { FactoryGirl.create(:garage) }
  let!(:tyre_fee) { FactoryGirl.create(:tyre_fee, garage: garage) }

  describe 'GET index' do
    let(:garage2) { FactoryGirl.create(:garage) }
    let!(:tyre_fee2) { FactoryGirl.create(:tyre_fee, garage: garage2) }
    it 'should show only the tyre fees of a given garage' do
      get :index, { garage_id: garage }
      expect(assigns(:tyre_fees).count).to eq(1)
      expect(assigns(:tyre_fees).first).to eq(tyre_fee)
    end
  end

  describe 'GET new' do
    it 'assigns a new tyre_fee as @tyre_fee' do
      get :new, { garage_id: garage }
      expect(assigns(:tyre_fee)).to be_a_new(TyreFee)
    end
  end

  describe 'GET edit' do
    it 'assigns the requested tyre_fee as @tyre_fee' do
      get :edit, { garage_id: garage, id: tyre_fee.to_param }
      expect(assigns(:tyre_fee)).to eq(tyre_fee)
    end
  end

  describe 'POST create' do
    describe 'with valid params' do
      it 'creates a new TyreFee' do
        expect {
          post :create, garage_params
        }.to change(TyreFee, :count).by(1)
      end

      it 'assigns a newly created tyre_fee as @tyre_fee' do
        post :create, { garage_id: garage, tyre_fee: valid_attributes }
        expect(assigns(:tyre_fee)).to be_a(TyreFee)
        expect(assigns(:tyre_fee)).to be_persisted
      end

      it 'redirects to the created tyre_fee' do
        post :create, { garage_id: garage, tyre_fee: valid_attributes }
        expect(response).to redirect_to garage_tyre_fees_url(garage)
      end
    end

    describe 'with invalid params' do
      it 'assigns a newly created but unsaved tyre_fee as @tyre_fee' do
        # Trigger the behavior that occurs when invalid params are submitted
        allow_any_instance_of(TyreFee).to receive(:save).and_return(false)
        post :create, { garage_id: garage, tyre_fee: invalid_attributes }
        expect(assigns(:tyre_fee)).to be_a_new(TyreFee)
      end

      it 're-renders the new template' do
        # Trigger the behavior that occurs when invalid params are submitted
        allow_any_instance_of(TyreFee).to receive(:save).and_return(false)
        post :create, { garage_id: garage, tyre_fee: invalid_attributes }
        expect(response).to render_template('new')
      end
    end
  end

  describe 'PUT update' do
    describe 'with valid params' do
      it 'updates the requested tyre_fee' do
        expect_any_instance_of(TyreFee).to receive(:update).with('vehicle_type' => '1')
        posted_params = { 'vehicle_type' => '1' }
        put :update, { garage_id: garage, id: tyre_fee.to_param, tyre_fee: posted_params }
      end

      it 'assigns the requested tyre_fee as @tyre_fee' do
        put :update, { garage_id: garage, id: tyre_fee.to_param, tyre_fee: valid_attributes }
        expect(assigns(:tyre_fee)).to eq(tyre_fee)
      end

      it 'redirects to the tyre_fee' do
        put :update, { garage_id: garage, id: tyre_fee.to_param, tyre_fee: valid_attributes }
        expect(response).to redirect_to garage_tyre_fees_url(garage)
      end
    end

    describe 'with invalid params' do
      it 'assigns the tyre_fee as @tyre_fee' do
        # Trigger the behavior that occurs when invalid params are submitted
        allow_any_instance_of(TyreFee).to receive(:save).and_return(false)
        put :update, { garage_id: garage, id: tyre_fee.to_param, tyre_fee: invalid_attributes }
        expect(assigns(:tyre_fee)).to eq(tyre_fee)
      end

      it 're-renders the edit template' do
        # Trigger the behavior that occurs when invalid params are submitted
        allow_any_instance_of(TyreFee).to receive(:save).and_return(false)
        put :update, { garage_id: garage, id: tyre_fee.to_param, tyre_fee: invalid_attributes }
        expect(response).to render_template('edit')
      end
    end
  end

  describe 'DELETE destroy' do
    it 'destroys the requested tyre_fee' do
      expect {
        delete :destroy, { garage_id: garage, id: tyre_fee.to_param }
      }.to change(TyreFee, :count).by(-1)
    end

    it 'redirects to the tyre_fees list' do
      delete :destroy, { garage_id: garage, id: tyre_fee.to_param }
      expect(response).to redirect_to garage_tyre_fees_url(garage)
    end
  end
end
