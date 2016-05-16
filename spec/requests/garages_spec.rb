describe "Garages" do
  describe "#index" do
    shared_examples_for "an authorized page" do
      it "returning status 200" do
        FactoryGirl.create(:garage)
        get garages_path
        expect(response.status).to be(200)
      end
    end

    shared_examples_for "an unauthorized page" do
      it "returning status 302" do
        FactoryGirl.create(:spanish_garage)
        get garages_path
        expect(response.status).to be(302)
      end
    end

    context 'with an admin' do
      login_admin
      it_behaves_like "an authorized page"
    end

    context 'with a country manager' do
      login_country_manager
      it_behaves_like "an authorized page"
    end

    context 'with an owner' do
      login_owner
      it_behaves_like 'an unauthorized page'
    end

    context 'with an api user' do
      login_api_user
      it_behaves_like 'an unauthorized page'
    end
  end

  describe "#show" do
    shared_examples_for "an authorized page" do
      it "returning status 200" do
        garage = FactoryGirl.create(:spanish_garage)
        get garage_path(garage.id)
        expect(response.status).to be(200)
      end
    end

    shared_examples_for "an unauthorized page" do
      it "returning status 302" do
        garage = FactoryGirl.create(:spanish_garage)
        get garage_path(garage.id)
        expect(response.status).to be(302)
      end
    end

    context 'with an admin' do
      login_admin
      it_behaves_like "an authorized page"
    end

    context 'with a country manager' do
      login_country_manager
      it_behaves_like "an authorized page"
    end

    context 'with an owner' do
      context 'over a garage of another owner' do
        login_owner
        it_behaves_like 'an unauthorized page'
      end

      context 'over his garage' do
        it "should return status 200 rendering his garage page" do
          user = FactoryGirl.create(:owner)
          garage = FactoryGirl.create(:garage, user: user)
          post_via_redirect user_session_path, 'user[email]' => user.email, 'user[password]' => user.password
          get garage_path(garage.id)
          expect(response.status).to be(200)
        end
      end
    end

    context 'with an api user' do
      login_api_user
      it_behaves_like 'an unauthorized page'
    end
  end
end
