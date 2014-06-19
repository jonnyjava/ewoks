module RequestMacros
  def login_user
    before(:each) do
      user = FactoryGirl.create(:admin)
      post_via_redirect user_session_path, 'user[email]' => user.email, 'user[password]' => user.password
    end
  end
end