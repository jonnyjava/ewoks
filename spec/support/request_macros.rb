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
      garage = FactoryGirl.create(:garage)
      garage.create_my_owner
      post_via_redirect user_session_path, 'user[email]' => garage.user.email, 'user[password]' => garage.user.password
    end
  end

  def login_api_user
    before(:each) do
      user = FactoryGirl.create(:api_user)
      post_via_redirect user_session_path, 'user[email]' => user.email, 'user[password]' => user.password
    end
  end
end
