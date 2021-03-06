describe UsersController do
  login_admin

  let(:valid_attributes) { { 'name' => "#{Faker::Name.name}", 'email' => "#{Faker::Internet::email}", 'password' => "12345678" } }
  let(:invalid_attributes) { { 'password' => 'password', 'password_confirmation' => 'password' } }
  let(:valid_update_attributes_without_password) { { 'name' => "#{Faker::Name.name}" } }
  let(:valid_update_attributes_with_password) { { 'password' => '87654321', 'password_confirmation' => '87654321', 'current_password' => '12345678', 'name' => "#{Faker::Name.name}" } }
  let(:valid_session) { {} }

  let(:user) { FactoryGirl.create(:user) }

  describe 'GET index' do
    it 'assigns all users as @users' do
      get :index, {}
      expect(assigns(:users)).to eq(User.all)
    end

    context 'for a country manager' do
      login_country_manager
      it 'should list only user with the same country of the country manager' do
        spanish_owner = FactoryGirl.create(:user)
        another_owner = FactoryGirl.create(:user, country: 'Albania')
        get :index, {}
        filtered_users = assigns(:users)
        expect(filtered_users).to include(spanish_owner)
        expect(filtered_users).not_to include(another_owner)
      end
    end
  end

  describe 'GET show' do
    it 'assigns the requested user as @user' do
      get :show, {id: user.to_param}, valid_session
      expect(assigns(:user)).to eq(user)
    end
  end

  describe 'GET new' do
    it 'assigns a new user as @user' do
      get :new, {}, valid_session
      expect(assigns(:user)).to be_a_new(User)
    end
  end

  describe 'GET edit' do
    it 'assigns the requested user as @user' do
      get :edit, {id: user.to_param}
      expect(assigns(:user)).to eq(user)
    end
  end

  describe 'POST create' do
    describe 'with valid params' do
      it 'creates a new User' do
        expect {
          post :create, { user: valid_attributes}, valid_session
        }.to change(User, :count).by(1)
      end

      it 'assigns a newly created user as @user' do
        post :create, { user: valid_attributes }, valid_session
        expect(assigns(:user)).to be_a(User)
        expect(assigns(:user)).to be_persisted
      end

      it 'redirects to the created user' do
        post :create, { user: valid_attributes }, valid_session
        expect(response).to redirect_to(User.last)
      end
    end

    describe 'with invalid params' do
      it 'assigns a newly created but unsaved user as @user' do
        allow_any_instance_of(User).to receive(:save).and_return(false)
        post :create, { user: invalid_attributes }, valid_session
        expect(assigns(:user)).to be_a_new(User)
      end

      it "re-renders the 'new' template" do
        allow_any_instance_of(User).to receive(:save).and_return(false)
        post :create, { user: invalid_attributes }, valid_session
        expect(response).to render_template('new')
      end
    end
  end

  describe 'PUT update' do
    describe 'with valid params' do
      it 'assigns the requested user as @user' do
        put :update, { id: user.to_param, user: valid_attributes }, valid_session
        expect(assigns(:user)).to eq(user)
      end

      it 'redirects to the user without password' do
        put :update, { id: user.to_param, user: valid_update_attributes_without_password }, valid_session
        expect(response).to redirect_to(user)
      end

      it 'redirects to the user with password' do
        put :update, { id: user.to_param, user: valid_update_attributes_with_password }, valid_session
        expect(response).to redirect_to(user)
      end
    end

    describe 'with invalid params' do
      it 'assigns the user as @user' do
        allow_any_instance_of(User).to receive(:save).and_return(false)
        put :update, { id: user.to_param, user: invalid_attributes }, valid_session
        expect(assigns(:user)).to eq(user)
      end

      it "re-renders the 'edit' template" do
        allow_any_instance_of(User).to receive(:save).and_return(false)
        put :update, { id: user.to_param, user: invalid_attributes }, valid_session
        expect(response).to render_template('edit')
      end
    end
  end

  describe 'DELETE destroy' do
    it 'destroys the requested user' do
      user
      expect {
        delete :destroy, { id: user.to_param }, valid_session
      }.to change(User, :count).by(-1)
    end

    it 'redirects to the users list' do
      delete :destroy, { id: user.to_param }, valid_session
      expect(response).to redirect_to(users_url)
    end
  end

end
