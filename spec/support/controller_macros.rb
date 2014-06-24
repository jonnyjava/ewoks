module ControllerMacros
  def login_user
    before(:each) do
      @request.env['devise.mapping'] = Devise.mappings[:user]
      user = FactoryGirl.create(:admin)
      sign_in user
    end
  end

  def login_country_manager
    before(:each) do
      @request.env['devise.mapping'] = Devise.mappings[:user]
      user = FactoryGirl.create(:country_manager, email: "#{Faker::Internet::email}")
      sign_in user
    end
  end
end
