require 'spec_helper'

describe "Users" do
  describe "GET /users" do
    login_user
    it "works! (now write some real specs)" do
      get users_path
      expect(response.status).to be(200)
    end
  end
end
