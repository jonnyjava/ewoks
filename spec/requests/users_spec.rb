describe "Users" do
  let(:spanish_user) { FactoryGirl.create(:user) }
  let(:foreigner_user) { FactoryGirl.create(:user, country: 'Macondo') }

  shared_examples_for "an accessible page" do |path, object|
    it "returning status 200 rendering #{path}" do
      get build_path(path, object)
      expect(response.status).to be(200)
    end
  end

  shared_examples_for "a not accessible page" do |path, object|
    it "returning status 302 rendering #{path}" do
      get build_path(path, object)
      expect(response.status).to be(302)
    end
  end

  describe "#index"do
    context 'with an admin' do
      login_admin
      it_behaves_like "an accessible page", :users_path
    end

    context 'with a country_manager' do
      login_country_manager
      it_behaves_like "an accessible page", :users_path
    end

    context 'with an owner' do
      login_owner
      it_behaves_like "a not accessible page", :users_path
    end

    context 'with an api_user' do
      login_api_user
      it_behaves_like "a not accessible page", :users_path
    end
  end

  describe "#show"do
    context 'with an admin' do
      login_admin
      it_behaves_like "an accessible page", :user_path, :spanish_user
    end

    context 'with a country_manager' do
      login_country_manager
      it_behaves_like "an accessible page", :user_path, :spanish_user
      it_behaves_like "a not accessible page", :user_path, :foreigner_user
    end

    context 'with an owner' do
      login_owner
      it_behaves_like "a not accessible page", :user_path, :spanish_user
    end

    context 'with an api_user' do
      login_api_user
      it_behaves_like "a not accessible page", :user_path, :spanish_user
    end
  end

  describe "#new"do
    context 'with an admin' do
      login_admin
      it_behaves_like "an accessible page", :new_user_path
    end

    context 'with a country_manager' do
      login_country_manager
      it_behaves_like "a not accessible page", :new_user_path
    end

    context 'with an owner' do
      login_owner
      it_behaves_like "a not accessible page", :new_user_path
    end

    context 'with an api_user' do
      login_api_user
      it_behaves_like "a not accessible page", :new_user_path
    end
  end

  private
    def build_path(path, object)
      return send(path) unless object
      user = send(object)
      send(path, user.id)
    end
end