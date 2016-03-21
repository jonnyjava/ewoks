module RequestMacros
  def login_admin
    before(:each) do
      user = FactoryGirl.create(:admin)
      post_via_redirect user_session_path, 'user[email]' => user.email, 'user[password]' => user.password
    end
  end

  def login_country_manager
    before(:each) do
      user = FactoryGirl.create(:country_manager)
      post_via_redirect user_session_path, 'user[email]' => user.email, 'user[password]' => user.password
    end
  end

  def login_owner
    before(:each) do
      user = FactoryGirl.create(:owner)
      FactoryGirl.create(:garage, user: user)
      post_via_redirect user_session_path, 'user[email]' => user.email, 'user[password]' => user.password
    end
  end

  def login_api_user
    before(:each) do
      user = FactoryGirl.create(:api_user)
      post_via_redirect user_session_path, 'user[email]' => user.email, 'user[password]' => user.password
    end
  end

  def api_user_token
    before(:each) do
      user = FactoryGirl.create(:api_user)
      @auth_token = { 'Authorization' => token_header(user.auth_token) }
    end
  end
end
