require 'spec_helper'

describe GaragesController do
  login_user
  let(:valid_attributes) { FactoryGirl.attributes_for(:garage) }
  let(:invalid_attributes) { { 'wrong_param' => 'wrong' } }

  describe 'POST create' do
    describe 'with valid params' do
      it 'creates a new Garage' do
        expect {
          post :create, { garage: valid_attributes}
        }.to change(Garage, :count).by(1)
      end

      it 'assigns a newly created garage as @garage' do
        post :create, { garage: valid_attributes }
        assigns(:garage).should be_a(Garage)
        assigns(:garage).should be_persisted
      end

      it 'redirects to the created garage' do
        post :create, { garage: valid_attributes }
        response.should redirect_to(Garage.last)
      end
    end

    describe 'with invalid params' do
      it 'assigns a newly created but unsaved garage as @garage' do
        Garage.any_instance.stub(:save).and_return(false)
        post :create, { garage: invalid_attributes }
        assigns(:garage).should be_a_new(Garage)
      end

      it "re-renders the 'new' template" do
        Garage.any_instance.stub(:save).and_return(false)
        post :create, { garage: invalid_attributes }
        response.should render_template('new')
      end
    end
  end
end
