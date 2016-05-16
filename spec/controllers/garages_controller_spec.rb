describe GaragesController do
  login_admin
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
        expect(assigns(:garage)).to be_a(Garage)
        expect(assigns(:garage)).to be_persisted
      end

      it 'redirects to the created garage' do
        post :create, { garage: valid_attributes }
        expect(response).to redirect_to(Garage.last)
      end
    end

    describe 'with invalid params' do
      it 'assigns a newly created but unsaved garage as @garage' do
        allow_any_instance_of(Garage).to receive(:save).and_return(false)
        post :create, { garage: invalid_attributes }
        expect(assigns(:garage)).to be_a_new(Garage)
      end

      it "re-renders the 'new' template" do
        allow_any_instance_of(Garage).to receive(:save).and_return(false)
        post :create, { garage: invalid_attributes }
        expect(response).to render_template('new')
      end
    end
  end
end
